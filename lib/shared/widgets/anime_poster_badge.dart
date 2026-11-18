
import 'package:flutter/material.dart';

class AnimePosterBadge extends StatelessWidget {
  final Widget child;

  const AnimePosterBadge({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xCC09090F),
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
