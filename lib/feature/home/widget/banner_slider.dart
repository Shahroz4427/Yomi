import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yomi/data/anime_banner_data.dart';
import 'package:yomi/model/anime_banner.dart';
import 'package:yomi/shared/widgets/banner_pagination.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({
    super.key,
    this.height = 350,
    this.borderRadius = 16,
    this.onWatchNow,
    this.onAddToList,
    this.banners = AnimeBannerData.defaultBanners,
    this.autoSlideInterval = const Duration(seconds: 5),
  });

  final double height;
  final double borderRadius;
  final ValueChanged<AnimeBanner>? onWatchNow;
  final ValueChanged<AnimeBanner>? onAddToList;
  final List<AnimeBanner> banners;
  final Duration autoSlideInterval;

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late final PageController _pageController;
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  Timer? _autoSlideTimer;
  bool _isInteracting = false;

  static const Duration _slideDuration = Duration(milliseconds: 550);

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void didUpdateWidget(covariant BannerSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.banners.length != widget.banners.length) {
      _currentIndex.value = 0;

      if (_pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
    }

    if (oldWidget.autoSlideInterval != widget.autoSlideInterval ||
        oldWidget.banners.length != widget.banners.length) {
      _startAutoSlide();
    }
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();

    if (widget.banners.length < 2 ||
        widget.autoSlideInterval <= Duration.zero) {
      return;
    }

    _autoSlideTimer = Timer.periodic(widget.autoSlideInterval, (_) {
      if (!mounted || _isInteracting || !_pageController.hasClients) {
        return;
      }

      final nextIndex = (_currentIndex.value + 1) % widget.banners.length;

      _pageController.animateToPage(
        nextIndex,
        duration: _slideDuration,
        curve: Curves.easeInOutCubicEmphasized,
      );
    });
  }

  void _pauseAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = null;
  }

  void _resumeAutoSlide() {
    if (!mounted) return;

    _isInteracting = false;
    _startAutoSlide();
  }

  void _goToPage(int index) {
    if (!_pageController.hasClients ||
        index < 0 ||
        index >= widget.banners.length) {
      return;
    }

    _pageController.animateToPage(
      index,
      duration: _slideDuration,
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    _currentIndex.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Swipeable banner pages.
            Listener(
              onPointerDown: (_) {
                _isInteracting = true;
                _pauseAutoSlide();
              },
              onPointerUp: (_) {
                _resumeAutoSlide();
              },
              onPointerCancel: (_) {
                _resumeAutoSlide();
              },
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.banners.length,
                onPageChanged: (index) {
                  _currentIndex.value = index;
                },
                itemBuilder: (context, index) {
                  final banner = widget.banners[index];

                  return BannerPagination(
                    key: ValueKey(banner.image),
                    banner: banner,
                    onWatchNow: widget.onWatchNow,
                    onAddToList: widget.onAddToList,
                  );
                },
              ),
            ),

            // Right-side, vertically centered pagination.
            Positioned(
              top: 0,
              bottom: 0,
              right: 10,
              child: Center(
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentIndex,
                  builder: (context, currentIndex, _) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(widget.banners.length, (index) {
                        final selected = currentIndex == index;

                        return Semantics(
                          button: true,
                          selected: selected,
                          label: 'Banner ${index + 1}',
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => _goToPage(index),
                            child: SizedBox(
                              width: 30,
                              height: 32,
                              child: Center(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOutCubic,
                                  width: 6,
                                  height: selected ? 22 : 6,
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.white70,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: selected
                                        ? [
                                            BoxShadow(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withValues(alpha: 0.4),
                                              blurRadius: 8,
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
