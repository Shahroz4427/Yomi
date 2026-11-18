import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/feature/player/widget/player_controls.dart';

/// Black video area: loading spinner, error message or the playing video
/// with its controls.
class PlayerView extends StatelessWidget {
  const PlayerView({
    super.key,
    required this.controller,
    required this.hasError,
    required this.title,
    required this.isFullscreen,
    required this.onBack,
    required this.onToggleFullscreen,
    required this.onRetry,
  });

  /// Null while the video is loading.
  final VideoPlayerController? controller;
  final bool hasError;
  final String title;
  final bool isFullscreen;
  final VoidCallback onBack;
  final VoidCallback onToggleFullscreen;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller;

    return ColoredBox(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (hasError)
            _ErrorMessage(onRetry: onRetry)
          else if (controller == null)
            const Center(
              child: CircularProgressIndicator(color: AppTheme.secondaryColor),
            )
          else
            ValueListenableBuilder<VideoPlayerValue>(
              valueListenable: controller,
              builder: (context, value, _) {
                if (value.hasError) return _ErrorMessage(onRetry: onRetry);

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: value.aspectRatio,
                        child: VideoPlayer(controller),
                      ),
                    ),
                    PlayerControls(
                      key: ValueKey(controller),
                      controller: controller,
                      title: title,
                      isFullscreen: isFullscreen,
                      onBack: onBack,
                      onToggleFullscreen: onToggleFullscreen,
                    ),
                  ],
                );
              },
            ),

          // While loading or after an error the controls are not shown, so
          // keep a way out.
          if (hasError || controller == null)
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: Colors.white,
                  tooltip: 'Back',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppTheme.secondaryTextColor,
            size: 36,
          ),
          const SizedBox(height: 8),
          const Text(
            'Could not load the video',
            style: TextStyle(color: AppTheme.secondaryTextColor, fontSize: 13),
          ),
          const SizedBox(height: 6),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
