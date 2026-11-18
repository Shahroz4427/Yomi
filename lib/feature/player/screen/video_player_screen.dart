import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/episode.dart';
import 'package:yomi/feature/player/widget/player_episode_list.dart';
import 'package:yomi/feature/player/widget/player_view.dart';

/// Streams the selected episode and lists the other episodes below.
///
/// Rotates to landscape and hides the system bars in fullscreen mode.
class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    super.key,
    required this.animeTitle,
    required this.posterPath,
    required this.episodes,
    this.initialIndex = 0,
  });

  final String animeTitle;
  final String posterPath;
  final List<Episode> episodes;
  final int initialIndex;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  late int _episodeIndex = widget.initialIndex;

  bool _hasError = false;
  bool _isFullscreen = false;

  // Lets a newer load ignore the result of an older, slower one.
  int _loadId = 0;

  Episode get _episode => widget.episodes[_episodeIndex];

  @override
  void initState() {
    super.initState();
    _loadEpisode(_episodeIndex);
  }

  Future<void> _loadEpisode(int index) async {
    final loadId = ++_loadId;
    final previous = _controller;

    setState(() {
      _episodeIndex = index;
      _controller = null;
      _hasError = false;
    });

    // Dispose after the frame, once nothing listens to the old controller.
    WidgetsBinding.instance.addPostFrameCallback((_) => previous?.dispose());

    final controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.episodes[index].videoUrl),
    );

    try {
      await controller.initialize();

      if (!mounted || loadId != _loadId) {
        await controller.dispose();
        return;
      }

      await controller.play();
      setState(() => _controller = controller);
    } catch (_) {
      await controller.dispose();

      if (mounted && loadId == _loadId) {
        setState(() => _hasError = true);
      }
    }
  }

  Future<void> _setFullscreen(bool value) async {
    setState(() => _isFullscreen = value);

    if (value) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  // Back leaves fullscreen first, then closes the screen.
  void _onBack() {
    if (_isFullscreen) {
      _setFullscreen(false);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();

    // Restore the app defaults changed by fullscreen mode.
    SystemChrome.setPreferredOrientations(const <DeviceOrientation>[]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = PlayerView(
      controller: _controller,
      hasError: _hasError,
      title: '${widget.animeTitle} · Episode ${_episode.number}',
      isFullscreen: _isFullscreen,
      onBack: _onBack,
      onToggleFullscreen: () => _setFullscreen(!_isFullscreen),
      onRetry: () => _loadEpisode(_episodeIndex),
    );

    return PopScope(
      canPop: !_isFullscreen,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _setFullscreen(false);
      },
      child: Scaffold(
        backgroundColor: _isFullscreen
            ? Colors.black
            : AppTheme.backgroundColor,
        body: _isFullscreen
            ? SafeArea(child: player)
            : SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    AspectRatio(aspectRatio: 16 / 9, child: player),
                    Expanded(
                      child: PlayerEpisodeList(
                        animeTitle: widget.animeTitle,
                        posterPath: widget.posterPath,
                        episodes: widget.episodes,
                        currentIndex: _episodeIndex,
                        onEpisodeTap: _loadEpisode,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
