import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';

/// "Don't have an account? Sign up" / "Already have an account? Login".
class AuthModeToggle extends StatelessWidget {
  const AuthModeToggle({
    super.key,
    required this.isSignUp,
    required this.onToggle,
  });

  final bool isSignUp;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isSignUp ? 'Already have an account?' : "Don't have an account?",
          style: const TextStyle(
            color: AppTheme.secondaryTextColor,
            fontSize: 12,
          ),
        ),
        TextButton(
          onPressed: onToggle,
          child: Text(
            isSignUp ? 'Login' : 'Sign up',
            style: const TextStyle(
              color: AppTheme.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
