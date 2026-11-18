import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:yomi/feature/player/widget/player_progress_bar.dart';

/// Overlay on top of the video: back button, title, play / pause, +-10
/// seconds, progress bar and fullscreen button.
///
/// Tap the video to show or hide it. It hides itself after a few seconds
/// while the video is playing.
class PlayerControls extends StatefulWidget {
  const PlayerControls({
    super.key,
    required this.controller,
    required this.title,
    required this.isFullscreen,
    required this.onBack,
    required this.onToggleFullscreen,
  });

  final VideoPlayerController controller;
  final String title;
  final bool isFullscreen;
  final VoidCallback onBack;
  final VoidCallback onToggleFullscreen;

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  static const Duration _hideDelay = Duration(seconds: 3);
  static const Duration _seekStep = Duration(seconds: 10);

  Timer? _hideTimer;
  bool _visible = true;

  VideoPlayerController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _scheduleHide();
  }

  void _scheduleHide() {
    _hideTimer?.cancel();
    _hideTimer = Timer(_hideDelay, () {
      if (mounted && _controller.value.isPlaying) {
        setState(() => _visible = false);
      }
    });
  }

  void _toggleVisible() {
    setState(() => _visible = !_visible);

    if (_visible) _scheduleHide();
  }

  void _togglePlay() {
    final value = _controller.value;

    if (value.isPlaying) {
      _controller.pause();
    } else {
      final isFinished =
          value.duration > Duration.zero && value.position >= value.duration;

      if (isFinished) _controller.seekTo(Duration.zero);
      _controller.play();
    }

    _scheduleHide();
  }

  void _seekBy(Duration offset) {
    final value = _controller.value;
    final target = value.position + offset;

    if (target < Duration.zero) {
      _controller.seekTo(Duration.zero);
    } else if (target > value.duration) {
      _controller.seekTo(value.duration);
    } else {
      _controller.seekTo(target);
    }

    _scheduleHide();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggleVisible,
      child: ValueListenableBuilder<VideoPlayerValue>(
        valueListenable: _controller,
        builder: (context, value, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              AnimatedOpacity(
                opacity: _visible ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: IgnorePointer(
                  ignoring: !_visible,
                  child: _Overlay(
                    title: widget.title,
                    value: value,
                    isFullscreen: widget.isFullscreen,
                    onBack: widget.onBack,
                    onTogglePlay: _togglePlay,
                    onReplay: () => _seekBy(-_seekStep),
                    onForward: () => _seekBy(_seekStep),
                    onSeek: (position) {
                      _controller.seekTo(position);
                      _scheduleHide();
                    },
                    onToggleFullscreen: widget.onToggleFullscreen,
                  ),
                ),
              ),
              if (value.isBuffering)
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Overlay extends StatelessWidget {
  const _Overlay({
    required this.title,
    required this.value,
    required this.isFullscreen,
    required this.onBack,
    required this.onTogglePlay,
    required this.onReplay,
    required this.onForward,
    required this.onSeek,
    required this.onToggleFullscreen,
  });

  final String title;
  final VideoPlayerValue value;
  final bool isFullscreen;
  final VoidCallback onBack;
  final VoidCallback onTogglePlay;
  final VoidCallback onReplay;
  final VoidCallback onForward;
  final ValueChanged<Duration> onSeek;
  final VoidCallback onToggleFullscreen;

  @override
  Widget build(BuildContext context) {
    final isFinished =
        value.duration > Duration.zero && value.position >= value.duration;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xCC000000), Color(0x33000000), Color(0xCC000000)],
        ),
      ),
      child: Column(
        children: [
          // Top bar
          Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_rounded),
                color: Colors.white,
                tooltip: 'Back',
              ),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),

          // Center buttons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: onReplay,
                  icon: const Icon(Icons.replay_10_rounded),
                  iconSize: 34,
                  color: Colors.white,
                  tooltip: 'Back 10 seconds',
                ),
                const SizedBox(width: 18),
                IconButton(
                  onPressed: onTogglePlay,
                  icon: Icon(
                    isFinished
                        ? Icons.replay_rounded
                        : value.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                  ),
                  iconSize: 52,
                  color: Colors.white,
                  tooltip: value.isPlaying ? 'Pause' : 'Play',
                ),
                const SizedBox(width: 18),
                IconButton(
                  onPressed: onForward,
                  icon: const Icon(Icons.forward_10_rounded),
                  iconSize: 34,
                  color: Colors.white,
                  tooltip: 'Forward 10 seconds',
                ),
              ],
            ),
          ),

          // Bottom bar
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 4),
            child: Row(
              children: [
                Expanded(
                  child: PlayerProgressBar(
                    position: value.position,
                    duration: value.duration,
                    onSeek: onSeek,
                  ),
                ),
                IconButton(
                  onPressed: onToggleFullscreen,
                  icon: Icon(
                    isFullscreen
                        ? Icons.fullscreen_exit_rounded
                        : Icons.fullscreen_rounded,
                  ),
                  color: Colors.white,
                  tooltip: isFullscreen ? 'Exit fullscreen' : 'Fullscreen',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
