import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart'; // Uncomment if using geolocator

class SOSButton extends StatefulWidget {
  final bool isEnabled;
  final Duration disabledDuration;
  const SOSButton({super.key, this.isEnabled = true, this.disabledDuration = const Duration(seconds: 10)});

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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
              child: Icon(Icons.warning_amber_rounded, color: Color(0xFFE91E63), size: 24),
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
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFFE91E63).withOpacity(0.3 * (1 - _rippleAnimation.value)),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                // Main button with custom painter
                Transform.scale(
                  scale: _isPressed ? _scaleAnimation.value : _pulseAnimation.value,
                  child: CustomPaint(
                    size: const Size(70, 70),
                    painter: _SOSSplitCirclePainter(
                      isDisabled: _isDisabled,
                    ),
                    child: Container(
                      width: 70,
                      height: 70,
                      alignment: Alignment.center,
                      child: Text(
                        'SOS',
                        style: TextStyle(
                          color: _isDisabled ? Colors.grey[400] : Color(0xFFB71C1C),
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                // Disabled overlay
                if (_isDisabled)
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.timer_rounded,
                        color: Colors.white,
                        size: 20,
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

class _SOSSplitCirclePainter extends CustomPainter {
  final bool isDisabled;
  _SOSSplitCirclePainter({required this.isDisabled});

  @override
  void paint(Canvas canvas, Size size) {
    final double outerRadius = size.width / 2;
    final double borderWidth = 10;
    final double innerRadius = outerRadius - borderWidth;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Shadow
    canvas.drawCircle(
      center,
      outerRadius - 2,
      Paint()
        ..color = Colors.black.withOpacity(0.18)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Left half (darker red)
    final Paint leftPaint = Paint()
      ..color = isDisabled ? Colors.grey[400]! : Color(0xFFB71C1C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerRadius - borderWidth / 2),
      0.5 * 3.1415926535,
      3.1415926535,
      false,
      leftPaint,
    );

    // Right half (lighter red)
    final Paint rightPaint = Paint()
      ..color = isDisabled ? Colors.grey[300]! : Color(0xFFD32F2F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerRadius - borderWidth / 2),
      1.5 * 3.1415926535,
      3.1415926535,
      false,
      rightPaint,
    );

    // Inner white circle
    final Paint innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, innerRadius, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
