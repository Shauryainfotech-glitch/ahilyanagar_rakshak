import 'package:flutter/material.dart';
import 'main.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final subTextColor = Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7) ?? Colors.black54;
    final iconColor = Theme.of(context).iconTheme.color ?? Colors.black;
    final gradientColors = isDark
        ? [Color(0xFF181A20), Color(0xFF23284A)]
        : [Color(0xFFF5F5F5), Color(0xFFE0E0E0)];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.security, size: 80, color: iconColor),
              SizedBox(height: 24),
              Text(
                'Welcome to Ahilyanagar Police',
                style: TextStyle(fontSize: 24, color: textColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Your safety, our priority',
                style: TextStyle(fontSize: 16, color: subTextColor),
              ),
              SizedBox(height: 32),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(iconColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

