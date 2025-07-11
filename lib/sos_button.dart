import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:geolocator/geolocator.dart'; // Uncomment if using geolocator

class SOSButton extends StatefulWidget {
  final bool isEnabled;
  final Duration disabledDuration;
  const SOSButton({
    super.key,
    this.isEnabled = true,
    this.disabledDuration = const Duration(seconds: 10),
  });

  @override
  State<SOSButton> createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> with TickerProviderStateMixin {
  bool _isPressed = false;
  bool _isDisabled = false;
  late AnimationController _pulseController;
  late AnimationController _rippleController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rippleAnimation;
  late Animation<double> _scaleAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  Future<void> _triggerSOS() async {
    setState(() => _isPressed = true);
    HapticFeedback.heavyImpact();
    _rippleController.forward();

    // Get user location
    Position? position;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location services are disabled!')),
          );
        }
        await Geolocator.openLocationSettings();
        setState(() => _isPressed = false);
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Location permission denied!')),
            );
          }
          setState(() => _isPressed = false);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location permission permanently denied!')),
          );
        }
        setState(() => _isPressed = false);
        return;
      }
      // Location fetch with timeout
      position =
          await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          ).timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception('Location fetch timeout');
            },
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Unable to fetch location!')));
      }
      setState(() => _isPressed = false);
      return;
    }

    // Send SOS alert to Firebase only if location is available
    try {
      final user = FirebaseAuth.instance.currentUser;
      final dbRef = FirebaseDatabase.instance.ref().child('sos_alerts').push();
      await dbRef.set({
        'uid': user?.uid,
        'email': user?.email,
        'timestamp': DateTime.now().toIso8601String(),
        'location': {
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
      });
      // Siren play logic: 10 सेकंड तक loop में बजे, फिर बंद हो जाए
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      print('Playing siren...');
      _audioPlayer.play(AssetSource('siren.mp3'));
      Future.delayed(const Duration(seconds: 10), () {
        print('Stopping siren...');
        _audioPlayer.stop();
      });
    } catch (e) {}

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isPressed = false);
    setState(() => _isDisabled = true);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'SOS Alert Sent! Help is on the way.',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFF4CAF50),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(16),
        ),
      );
    }
    await Future.delayed(widget.disabledDuration);
    if (mounted) setState(() => _isDisabled = false);
  }

  void _onTap() async {
    if (_isDisabled || !widget.isEnabled) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color(0xFF1E2337),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFE91E63).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFE91E63),
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Send SOS Alert?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to send an emergency SOS alert? This will notify emergency services immediately.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Send SOS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _triggerSOS();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: 'SOS Button. Press to send an emergency alert.',
      button: true,
      child: GestureDetector(
        onTap: _onTap,
        child: AnimatedBuilder(
          animation: Listenable.merge([_pulseAnimation, _rippleAnimation]),
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Ripple effect
                if (_rippleController.status == AnimationStatus.forward)
                  Transform.scale(
                    scale: _rippleAnimation.value * 2.0,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.error.withOpacity(
                            0.3 * (1 - _rippleAnimation.value),
                          ),
                          width: 3,
                        ),
                      ),
                    ),
                  ),

                // Main button with pulse animation
                Transform.scale(
                  scale: _isPressed
                      ? _scaleAnimation.value
                      : _pulseAnimation.value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isDisabled
                            ? [
                                theme.disabledColor,
                                theme.disabledColor.withOpacity(0.7),
                              ]
                            : [
                                theme.colorScheme.error,
                                theme.colorScheme.error.withOpacity(0.7),
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.error.withOpacity(0.4),
                          blurRadius: 24,
                          spreadRadius: 2,
                          offset: Offset(0, 8),
                        ),
                        BoxShadow(
                          color: theme.colorScheme.error.withOpacity(0.15),
                          blurRadius: 40,
                          spreadRadius: 0,
                          offset: Offset(0, 16),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sos, color: Colors.white, size: 38),
                          SizedBox(height: 2),
                          // Text(
                          //   'SOS',
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.w900,
                          //     fontSize: 10,
                          //     letterSpacing: 2.0,
                          //     shadows: [
                          //       Shadow(
                          //         color: theme.colorScheme.error.withOpacity(
                          //           0.5,
                          //         ),
                          //         blurRadius: 8,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Disabled overlay
                if (_isDisabled)
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.timer_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
