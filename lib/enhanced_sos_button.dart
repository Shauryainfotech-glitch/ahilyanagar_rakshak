import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'services/firebase_service.dart';
import 'services/location_service.dart';
import 'services/media_service.dart';
import 'services/notification_service.dart';

class EnhancedSOSButton extends StatefulWidget {
  const EnhancedSOSButton({super.key});

  @override
  State<EnhancedSOSButton> createState() => _EnhancedSOSButtonState();
}

class _EnhancedSOSButtonState extends State<EnhancedSOSButton>
    with TickerProviderStateMixin {
  final FirebaseService _firebaseService = FirebaseService();
  final LocationService _locationService = LocationService();
  final MediaService _mediaService = MediaService();
  final NotificationService _notificationService = NotificationService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  late AnimationController _pulseController;
  late AnimationController _shakeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shakeAnimation;

  bool _isSOSActive = false;
  bool _isLocationTracking = false;
  Position? _currentPosition;
  List<Map<String, dynamic>> _capturedMedia = [];
  String? _currentAlertId;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeServices();
  }

  void _initializeAnimations() {
    // Pulse animation for SOS button
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Shake animation for emergency effect
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  Future<void> _initializeServices() async {
    try {
      // Initialize location tracking
      await _locationService.startLocationTracking();
      setState(() {
        _isLocationTracking = true;
      });

      // Get current position
      _currentPosition = await _locationService.getCurrentPosition();
      if (_currentPosition != null) {
        setState(() {});
      }

      // Initialize media service
      await _mediaService.initializeCamera();

      // Initialize notification service
      await _notificationService.initialize();
    } catch (e) {
      print('Error initializing services: $e');
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shakeController.dispose();
    _audioPlayer.dispose();
    _locationService.dispose();
    _mediaService.disposeCamera();
    super.dispose();
  }

  Future<void> _activateSOS() async {
    if (_isSOSActive) return;

    try {
      setState(() {
        _isSOSActive = true;
      });

      // Start animations
      _pulseController.repeat(reverse: true);
      _shakeController.repeat(reverse: true);

      // Play siren sound
      await _playSirenSound();

      // Get current location
      _currentPosition = await _locationService.getCurrentPosition();
      if (_currentPosition == null) {
        _showErrorDialog('Location Error', 'Unable to get your current location. Please enable location services.');
        return;
      }

      // Show SOS activation dialog
      await _showSOSActivationDialog();

      // --- NEW: Notify all police officers ---
      try {
        await _notificationService.sendSOSToPolice(
          latitude: _currentPosition!.latitude,
          longitude: _currentPosition!.longitude,
        );
      } catch (e) {
        print('Error sending SOS notification to police: $e');
      }
      // --- END NEW ---

    } catch (e) {
      print('Error activating SOS: $e');
      _showErrorDialog('SOS Error', 'Failed to activate SOS. Please try again.');
    }
  }

  Future<void> _deactivateSOS() async {
    if (!_isSOSActive) return;

    try {
      setState(() {
        _isSOSActive = false;
      });

      // Stop animations
      _pulseController.stop();
      _shakeController.stop();

      // Stop siren sound
      await _audioPlayer.stop();

      // Update SOS status if alert was created
      if (_currentAlertId != null) {
        await _firebaseService.updateSOSStatus(_currentAlertId!, 'cancelled', null);
        _currentAlertId = null;
      }

      // Clear captured media
      _capturedMedia.clear();

    } catch (e) {
      print('Error deactivating SOS: $e');
    }
  }

  Future<void> _playSirenSound() async {
    try {
      await _audioPlayer.play(AssetSource('siren.mp3'));
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      print('Error playing siren sound: $e');
    }
  }

  Future<void> _showSOSActivationDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.emergency, color: Colors.white, size: 32),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'SOS ACTIVATED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Emergency services have been notified of your location.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Current Location:',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Lat: ${_currentPosition?.latitude.toStringAsFixed(6)}\nLng: ${_currentPosition?.longitude.toStringAsFixed(6)}',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(true),
                    icon: Icon(Icons.camera_alt),
                    label: Text('Add Evidence'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(false),
                    icon: Icon(Icons.call),
                    label: Text('Call Police'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel SOS',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );

    if (result == true) {
      // User wants to add evidence
      await _captureEvidence();
    } else if (result == false) {
      // User wants to call police or cancel
      await _handleSOSAction();
    }
  }

  Future<void> _captureEvidence() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Capture Evidence'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take Photo'),
              onTap: () => Navigator.of(context).pop('photo'),
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Record Video'),
              onTap: () => Navigator.of(context).pop('video'),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () => Navigator.of(context).pop('gallery'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: Text('Cancel'),
          ),
        ],
      ),
    );

    if (result != null) {
      try {
        Map<String, dynamic>? mediaFile;
        
        switch (result) {
          case 'photo':
            mediaFile = await _mediaService.capturePhotoWithLocation();
            break;
          case 'video':
            mediaFile = await _mediaService.recordVideoWithLocation();
            break;
          case 'gallery':
            mediaFile = await _mediaService.pickImageFromGallery();
            break;
        }

        if (mediaFile != null) {
          setState(() {
            _capturedMedia.add(mediaFile!);
          });

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Evidence captured successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        print('Error capturing evidence: $e');
        _showErrorDialog('Capture Error', 'Failed to capture evidence. Please try again.');
      }
    }

    // Continue with SOS action
    await _handleSOSAction();
  }

  Future<void> _handleSOSAction() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showErrorDialog('Authentication Error', 'Please log in to use SOS feature.');
        return;
      }

      // Create SOS alert in Firebase
      _currentAlertId = await _firebaseService.createSOSAlert(
        userId: user.uid,
        position: _currentPosition!,
        description: 'SOS activated by user',
        mediaUrls: _capturedMedia.map((media) => media['path'] as String).toList(),
      );

      // Send notification to police
      await _notificationService.showSOSNotification(
        title: 'SOS Alert',
        body: 'Emergency SOS activated at ${_currentPosition!.latitude.toStringAsFixed(6)}, ${_currentPosition!.longitude.toStringAsFixed(6)}',
        alertId: _currentAlertId!,
      );

      // Show success dialog
      await _showSuccessDialog();

    } catch (e) {
      print('Error handling SOS action: $e');
      _showErrorDialog('SOS Error', 'Failed to send SOS alert. Please try again.');
    }
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.green[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 32),
            SizedBox(width: 12),
            Text(
              'SOS Sent Successfully',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        content: Text(
          'Emergency services have been notified and are on their way. Stay calm and stay in a safe location.',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deactivateSOS();
            },
            child: Text('OK'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deactivateSOS();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _isSOSActive ? _deactivateSOS : _activateSOS,
      onTap: _isSOSActive ? null : _activateSOS,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _isSOSActive ? _pulseAnimation.value : 1.0,
            child: AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: _isSOSActive 
                    ? Offset(_shakeAnimation.value * (DateTime.now().millisecond % 2 == 0 ? 1 : -1), 0)
                    : Offset.zero,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: _isSOSActive 
                          ? [Colors.red, Colors.red[800]!]
                          : [Colors.red[600]!, Colors.red[400]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _isSOSActive 
                            ? Colors.red.withOpacity(0.6)
                            : Colors.red.withOpacity(0.3),
                          blurRadius: _isSOSActive ? 20 : 10,
                          spreadRadius: _isSOSActive ? 5 : 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.emergency,
                          color: Colors.white,
                          size: _isSOSActive ? 40 : 32,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _isSOSActive ? 18 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_isSOSActive) ...[
                          SizedBox(height: 4),
                          Text(
                            'HOLD TO STOP',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
