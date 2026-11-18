import 'package:flutter/material.dart';

/// "Watch Now" and "My List" buttons.
class DetailsActions extends StatelessWidget {
  const DetailsActions({
    super.key,
    required this.isInList,
    required this.onWatch,
    required this.onToggleList,
  });

  final bool isInList;
  final VoidCallback onWatch;
  final VoidCallback onToggleList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ElevatedButton.icon(
            onPressed: onWatch,
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Watch Now'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: OutlinedButton.icon(
            onPressed: onToggleList,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            icon: Icon(isInList ? Icons.check_rounded : Icons.add_rounded),
            label: const Text('My List'),
          ),
        ),
      ],
    );
  }
}
