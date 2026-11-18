import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/core/utils/duration_labels.dart';

/// Seek slider with the current time on the left and the total on the right.
class PlayerProgressBar extends StatefulWidget {
  const PlayerProgressBar({
    super.key,
    required this.position,
    required this.duration,
    required this.onSeek,
  });

  final Duration position;
  final Duration duration;
  final ValueChanged<Duration> onSeek;

  @override
  State<PlayerProgressBar> createState() => _PlayerProgressBarState();
}

class _PlayerProgressBarState extends State<PlayerProgressBar> {
  // Slider value (milliseconds) while the user drags; null otherwise.
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    final totalMs = widget.duration.inMilliseconds.toDouble();
    final hasDuration = totalMs > 0;

    final currentMs =
        _dragValue ??
        widget.position.inMilliseconds.toDouble().clamp(0.0, totalMs).toDouble();

    const textStyle = TextStyle(color: Colors.white, fontSize: 11);

    return Row(
      children: [
        Text(
          DurationLabels.format(Duration(milliseconds: currentMs.round())),
          style: textStyle,
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
              activeTrackColor: AppTheme.primaryColor,
              inactiveTrackColor: Colors.white24,
              thumbColor: AppTheme.secondaryColor,
            ),
            child: Slider(
              value: hasDuration ? currentMs : 0,
              max: hasDuration ? totalMs : 1,
              onChanged: hasDuration
                  ? (value) => setState(() => _dragValue = value)
                  : null,
              onChangeEnd: (value) {
                widget.onSeek(Duration(milliseconds: value.round()));
                setState(() => _dragValue = null);
              },
            ),
          ),
        ),
        Text(DurationLabels.format(widget.duration), style: textStyle),
      ],
    );
  }
}
