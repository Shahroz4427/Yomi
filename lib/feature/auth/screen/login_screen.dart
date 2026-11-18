import 'package:flutter/material.dart';
import 'package:yomi/core/constants/app_assets.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/feature/auth/widget/auth_form.dart';
import 'package:yomi/feature/auth/widget/auth_mode_toggle.dart';

/// Login / sign up page (UI only; there is no backend yet).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSignUp = false;

  void _onSubmitted() {
    final messenger = ScaffoldMessenger.of(context);
    final message = _isSignUp ? 'Account created (demo)' : 'Logged in (demo)';

    Navigator.pop(context);
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppAssets.logo, height: 64, fit: BoxFit.contain),
              const SizedBox(height: 28),
              Text(
                _isSignUp ? 'Create account' : 'Welcome back',
                style: const TextStyle(
                  color: AppTheme.primaryTextColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _isSignUp
                    ? 'Join Yomi to build your anime list'
                    : 'Log in to continue watching',
                style: const TextStyle(
                  color: AppTheme.secondaryTextColor,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 28),
              AuthForm(isSignUp: _isSignUp, onSubmitted: _onSubmitted),
              const SizedBox(height: 18),
              Center(
                child: AuthModeToggle(
                  isSignUp: _isSignUp,
                  onToggle: () => setState(() => _isSignUp = !_isSignUp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
