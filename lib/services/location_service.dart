import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_service.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  StreamSubscription<Position>? _locationSubscription;
  Timer? _locationUpdateTimer;
  Position? _lastKnownPosition;
  bool _isTracking = false;

  // Location tracking settings
  static const Duration _updateInterval = Duration(seconds: 30);
  static const double _minDistance = 10.0; // meters
  static const LocationAccuracy _accuracy = LocationAccuracy.high;

  // Get current position
  Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await _checkLocationPermission();
      if (!hasPermission) return null;

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: _accuracy,
      );
    } catch (e) {
      print('Error getting current position: $e');
      return null;
    }
  }

  // Start real-time location tracking
  Future<bool> startLocationTracking() async {
    try {
      final hasPermission = await _checkLocationPermission();
      if (!hasPermission) return false;

      if (_isTracking) return true;

      _isTracking = true;
      
      // Get initial position
      _lastKnownPosition = await getCurrentPosition();
      if (_lastKnownPosition != null) {
        await _updateLocationInFirebase(_lastKnownPosition!);
      }

      // Start continuous tracking
      _locationSubscription = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: _accuracy,
          distanceFilter: _minDistance.toInt(), // Fix: ensure int type
        ),
      ).listen(
        (Position position) async {
          _lastKnownPosition = position;
          await _updateLocationInFirebase(position);
        },
        onError: (error) {
          print('Location tracking error: $error');
        },
      );

      // Start periodic updates for Firebase
      _locationUpdateTimer = Timer.periodic(_updateInterval, (timer) async {
        if (_lastKnownPosition != null) {
          await _updateLocationInFirebase(_lastKnownPosition!);
        }
      });

      return true;
    } catch (e) {
      print('Error starting location tracking: $e');
      _isTracking = false;
      return false;
    }
  }

  // Stop location tracking
  void stopLocationTracking() {
    _isTracking = false;
    _locationSubscription?.cancel();
    _locationUpdateTimer?.cancel();
    _locationSubscription = null;
    _locationUpdateTimer = null;
  }

  // Update location in Firebase
  Future<void> _updateLocationInFirebase(Position position) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firebaseService.updateUserLocation(user.uid, position);
      }
    } catch (e) {
      print('Error updating location in Firebase: $e');
    }
  }

  // Check and request location permission
  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      return false;
    }

    return true;
  }

  // Get location permission status
  Future<LocationPermission> getLocationPermissionStatus() async {
    return await Geolocator.checkPermission();
  }

  // Request location permission
  Future<bool> requestLocationPermission() async {
    final permission = await Permission.location.request();
    return permission.isGranted;
  }

  // Calculate distance between two points
  double calculateDistance(Position start, Position end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  // Get address from coordinates
  Future<String?> getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}';
      }
      return null;
    } catch (e) {
      print('Error getting address: $e');
      return null;
    }
  }

  // Check if location is within police station radius
  Future<bool> isNearPoliceStation(Position userPosition, double radiusInMeters) async {
    // Define police station coordinates (Ahilyanagar area)
    final List<Map<String, dynamic>> policeStations = [
      {
        'name': 'Ahilyanagar Police Station',
        'latitude': 19.0760,
        'longitude': 72.8777,
      },
      {
        'name': 'Ahilyanagar Traffic Police Station',
        'latitude': 19.0765,
        'longitude': 72.8782,
      },
      {
        'name': 'Ahilyanagar Cyber Crime Cell',
        'latitude': 19.0755,
        'longitude': 72.8767,
      },
    ];

    for (var station in policeStations) {
      final distance = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        station['latitude'],
        station['longitude'],
      );

      if (distance <= radiusInMeters) {
        return true;
      }
    }

    return false;
  }

  // Get nearest police station
  Future<Map<String, dynamic>?> getNearestPoliceStation(Position userPosition) async {
    final List<Map<String, dynamic>> policeStations = [
      {
        'name': 'Ahilyanagar Police Station',
        'latitude': 19.0760,
        'longitude': 72.8777,
        'phone': '02462-123456',
        'address': 'Police Station Road, Ahilyanagar, Maharashtra 413501',
      },
      {
        'name': 'Ahilyanagar Traffic Police Station',
        'latitude': 19.0765,
        'longitude': 72.8782,
        'phone': '02462-123457',
        'address': 'Main Road, Near Bus Stand, Ahilyanagar, Maharashtra 413501',
      },
      {
        'name': 'Ahilyanagar Cyber Crime Cell',
        'latitude': 19.0755,
        'longitude': 72.8767,
        'phone': '02462-123458',
        'address': 'Police HQ, Cyber Crime Wing, Ahilyanagar, Maharashtra 413501',
      },
    ];

    Map<String, dynamic>? nearestStation;
    double minDistance = double.infinity;

    for (var station in policeStations) {
      final distance = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        station['latitude'],
        station['longitude'],
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearestStation = station;
      }
    }

    if (nearestStation != null) {
      nearestStation['distance'] = minDistance;
    }

    return nearestStation;
  }

  // Validate location for complaint submission
  Future<Map<String, dynamic>> validateComplaintLocation(Position position) async {
    final validation = {
      'isValid': true,
      'message': 'Location is valid',
      'nearestStation': null,
      'distance': null,
    };

    try {
      // Check if location is within reasonable bounds (Ahilyanagar area)
      const double maxLatitude = 19.1;
      const double minLatitude = 19.0;
      const double maxLongitude = 72.9;
      const double minLongitude = 72.8;

      if (position.latitude < minLatitude || 
          position.latitude > maxLatitude ||
          position.longitude < minLongitude ||
          position.longitude > maxLongitude) {
        validation['isValid'] = false;
        validation['message'] = 'Location is outside Ahilyanagar jurisdiction';
        return validation;
      }

      // Get nearest police station
      final nearestStation = await getNearestPoliceStation(position);
      if (nearestStation != null) {
        validation['nearestStation'] = nearestStation;
        validation['distance'] = nearestStation['distance'];

        // Check if too far from any police station (more than 10km)
        if (nearestStation['distance'] > 10000) {
          validation['isValid'] = false;
          validation['message'] = 'Location is too far from police stations';
        }
      }

      return validation;
    } catch (e) {
      validation['isValid'] = false;
      validation['message'] = 'Error validating location: $e';
      return validation;
    }
  }

  // Get location stream for real-time updates
  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: _accuracy,
        distanceFilter: _minDistance.toInt(), // Fix: ensure int type
      ),
    );
  }

  // Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Get last known position
  Position? get lastKnownPosition => _lastKnownPosition;

  // Check if currently tracking
  bool get isTracking => _isTracking;

  // Dispose resources
  void dispose() {
    stopLocationTracking();
  }
}
