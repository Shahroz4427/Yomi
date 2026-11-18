import 'package:flutter/material.dart';

/// App name and tagline that fade and slide up.
class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key, required this.fade, required this.slide});

  final Animation<double> fade;
  final Animation<Offset> slide;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: Column(
          children: [
            const Text(
              'YOMI',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                letterSpacing: 9,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'YOUR ANIME JOURNEY STARTS HERE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                color: Colors.white.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
