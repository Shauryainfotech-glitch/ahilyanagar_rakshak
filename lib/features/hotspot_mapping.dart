import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import '../services/firebase_service.dart';
import '../services/location_service.dart';

class HotspotMappingScreen extends StatefulWidget {
  const HotspotMappingScreen({super.key});

  @override
  State<HotspotMappingScreen> createState() => _HotspotMappingScreenState();
}

class _HotspotMappingScreenState extends State<HotspotMappingScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final LocationService _locationService = LocationService();
  
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  Set<Polygon> _polygons = {};
  
  Position? _currentPosition;
  List<Map<String, dynamic>> _hotspots = [];
  String _selectedFilter = 'all';
  
  // Map settings
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(19.0760, 72.8777), // Ahilyanagar center
    zoom: 14.0,
  );

  @override
  void initState() {
    super.initState();
    _initializeMap();
    _loadHotspots();
  }

  Future<void> _initializeMap() async {
    try {
      _currentPosition = await _locationService.getCurrentPosition();
      if (_currentPosition != null) {
        _animateToCurrentLocation();
      }
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<void> _loadHotspots() async {
    try {
      final stream = _firebaseService.getHotspotsStream();
      stream.listen((event) {
        if (event.snapshot.value != null) {
          final hotspotsData = event.snapshot.value as Map<dynamic, dynamic>;
          _hotspots = hotspotsData.entries.map((entry) {
            final data = entry.value as Map<dynamic, dynamic>;
            return {
              'id': entry.key,
              'type': data['type'],
              'latitude': data['latitude'],
              'longitude': data['longitude'],
              'description': data['description'],
              'severity': data['severity'],
              'createdAt': data['createdAt'],
              'active': data['active'],
            };
          }).toList();

          _updateMarkers();
        }
      });
    } catch (e) {
      print('Error loading hotspots: $e');
    }
  }

  void _updateMarkers() {
    _markers.clear();
    _circles.clear();

    for (var hotspot in _hotspots) {
      if (_selectedFilter == 'all' || hotspot['type'] == _selectedFilter) {
        final position = LatLng(hotspot['latitude'], hotspot['longitude']);
        
        // Create marker
        _markers.add(Marker(
          markerId: MarkerId(hotspot['id']),
          position: position,
          infoWindow: InfoWindow(
            title: _getHotspotTitle(hotspot['type']),
            snippet: hotspot['description'],
          ),
          icon: _getHotspotIcon(hotspot['type'], hotspot['severity']),
          onTap: () => _showHotspotDetails(hotspot),
        ));

        // Create circle for severity visualization
        _circles.add(Circle(
          circleId: CircleId(hotspot['id']),
          center: position,
          radius: _getSeverityRadius(hotspot['severity']),
          fillColor: _getSeverityColor(hotspot['severity']).withOpacity(0.3),
          strokeColor: _getSeverityColor(hotspot['severity']),
          strokeWidth: 2,
        ));
      }
    }

    setState(() {});
  }

  String _getHotspotTitle(String type) {
    switch (type) {
      case 'crime':
        return 'Crime Hotspot';
      case 'accident':
        return 'Accident Hotspot';
      case 'traffic':
        return 'Traffic Violation Hotspot';
      default:
        return 'Incident Hotspot';
    }
  }

  BitmapDescriptor _getHotspotIcon(String type, int severity) {
    switch (type) {
      case 'crime':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 'accident':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
      case 'traffic':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
      default:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    }
  }

  double _getSeverityRadius(int severity) {
    // Radius based on severity (1-5 scale)
    switch (severity) {
      case 1:
        return 50.0;
      case 2:
        return 100.0;
      case 3:
        return 150.0;
      case 4:
        return 200.0;
      case 5:
        return 250.0;
      default:
        return 100.0;
    }
  }

  Color _getSeverityColor(int severity) {
    switch (severity) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      case 5:
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  void _showHotspotDetails(Map<String, dynamic> hotspot) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getHotspotIconData(hotspot['type']),
                          color: _getSeverityColor(hotspot['severity']),
                          size: 32,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getHotspotTitle(hotspot['type']),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Severity Level: ${hotspot['severity']}/5',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20),
                    
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      hotspot['description'],
                      style: TextStyle(fontSize: 14),
                    ),
                    
                    SizedBox(height: 20),
                    
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Latitude: ${hotspot['latitude'].toStringAsFixed(6)}\nLongitude: ${hotspot['longitude'].toStringAsFixed(6)}',
                      style: TextStyle(fontSize: 14),
                    ),
                    
                    SizedBox(height: 20),
                    
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _navigateToHotspot(hotspot),
                            icon: Icon(Icons.directions),
                            label: Text('Navigate'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _reportNewIncident(hotspot),
                            icon: Icon(Icons.report),
                            label: Text('Report'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getHotspotIconData(String type) {
    switch (type) {
      case 'crime':
        return Icons.security;
      case 'accident':
        return Icons.car_crash;
      case 'traffic':
        return Icons.traffic;
      default:
        return Icons.location_on;
    }
  }

  void _navigateToHotspot(Map<String, dynamic> hotspot) {
    final position = LatLng(hotspot['latitude'], hotspot['longitude']);
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(position, 16));
    Navigator.of(context).pop();
  }

  void _reportNewIncident(Map<String, dynamic> hotspot) {
    Navigator.of(context).pop();
    // Navigate to complaint form with pre-filled location
    Navigator.of(context).pushNamed('/complaint_registration', arguments: {
      'latitude': hotspot['latitude'],
      'longitude': hotspot['longitude'],
      'type': hotspot['type'],
    });
  }

  void _animateToCurrentLocation() {
    if (_currentPosition != null && _mapController != null) {
      final position = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incident Hotspots'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: _animateToCurrentLocation,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
                _updateMarkers();
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'all',
                child: Text('All Incidents'),
              ),
              PopupMenuItem(
                value: 'crime',
                child: Text('Crime'),
              ),
              PopupMenuItem(
                value: 'accident',
                child: Text('Accidents'),
              ),
              PopupMenuItem(
                value: 'traffic',
                child: Text('Traffic Violations'),
              ),
            ],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.filter_list),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            initialCameraPosition: _initialPosition,
            markers: _markers,
            circles: _circles,
            polygons: _polygons,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onTap: (position) {
              // Clear any selected markers
            },
          ),
          
          // Legend
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Legend',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildLegendItem('Crime', Colors.red),
                  _buildLegendItem('Accident', Colors.orange),
                  _buildLegendItem('Traffic', Colors.yellow),
                  SizedBox(height: 8),
                  Text(
                    'Circle size = Severity',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Statistics
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Total', _hotspots.length.toString()),
                  _buildStatItem('Crime', _hotspots.where((h) => h['type'] == 'crime').length.toString()),
                  _buildStatItem('Accident', _hotspots.where((h) => h['type'] == 'accident').length.toString()),
                  _buildStatItem('Traffic', _hotspots.where((h) => h['type'] == 'traffic').length.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewHotspot(),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        child: Icon(Icons.add_location),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red[700],
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  void _addNewHotspot() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Hotspot'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Describe the incident...',
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Type'),
              items: [
                DropdownMenuItem(value: 'crime', child: Text('Crime')),
                DropdownMenuItem(value: 'accident', child: Text('Accident')),
                DropdownMenuItem(value: 'traffic', child: Text('Traffic Violation')),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Severity (1-5)'),
              items: List.generate(5, (index) => 
                DropdownMenuItem(value: index + 1, child: Text('${index + 1}'))
              ),
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add hotspot logic here
              Navigator.of(context).pop();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
} 