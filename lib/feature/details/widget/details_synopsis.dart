import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';

/// Synopsis text that collapses to a few lines with "Read more".
class DetailsSynopsis extends StatefulWidget {
  const DetailsSynopsis({super.key, required this.text});

  final String text;

  @override
  State<DetailsSynopsis> createState() => _DetailsSynopsisState();
}

class _DetailsSynopsisState extends State<DetailsSynopsis> {
  static const int _collapsedLines = 4;
  static const TextStyle _style = TextStyle(
    color: AppTheme.secondaryTextColor,
    fontSize: 13,
    height: 1.5,
  );

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: _style),
          maxLines: _collapsedLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isLong = painter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              maxLines: _expanded ? null : _collapsedLines,
              overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: _style,
            ),
            if (isLong) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Text(
                  _expanded ? 'Show less' : 'Read more',
                  style: const TextStyle(
                    color: AppTheme.secondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
