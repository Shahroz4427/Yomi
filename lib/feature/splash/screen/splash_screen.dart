import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/feature/splash/widget/splash_footer.dart';
import 'package:yomi/feature/splash/widget/splash_loader.dart';
import 'package:yomi/feature/splash/widget/splash_logo.dart';
import 'package:yomi/feature/splash/widget/splash_title.dart';

/// Animated launch screen. Shows [nextScreen] after a short delay.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.nextScreen});

  /// Screen to open when the splash animation is finished.
  final Widget nextScreen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const Duration _displayDuration = Duration(seconds: 3);
  static const Duration _transitionDuration = Duration(milliseconds: 600);

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideAnimation;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
        );

    _controller.forward();

    _timer = Timer(_displayDuration, _openNextScreen);
  }

  void _openNextScreen() {
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            widget.nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: _transitionDuration,
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 0.9,
            colors: [
              Color(0xFF211B3A),
              Color(0xFF10101A),
              AppTheme.backgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SplashLogo(fade: _fadeAnimation, scale: _scaleAnimation),
                    const SizedBox(height: 25),
                    SplashTitle(fade: _fadeAnimation, slide: _slideAnimation),
                    const SizedBox(height: 55),
                    SplashLoader(fade: _fadeAnimation),
                  ],
                ),
              ),
              Positioned(
                bottom: 25,
                left: 0,
                right: 0,
                child: SplashFooter(fade: _fadeAnimation),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
