import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/service/telegram_service/telegram_utils.dart';
import 'package:nomix/core/widgets/canvas/romb_clipper.dart';
import 'package:nomix/core/widgets/weavy_shimmer_text.dart';

class SplashRevealWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Color overlayColor;
  final VoidCallback? onAnimationComplete;
  final SplashRevealController controller;

  const SplashRevealWidget({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 5000),
    this.overlayColor = Colors.white,
    this.onAnimationComplete,
  }) : super(key: key);

  @override
  State<SplashRevealWidget> createState() => _SplashRevealWidgetState();
}

class _SplashRevealWidgetState extends State<SplashRevealWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    widget.controller._state = this;
  }

  Future<void> _startAnimation() async {
    // 1) Запускаем вибрацию в фоне, но не ждём её окончания
    TelegramUtils.startVibration();

    // 2) Сразу пускаем анимацию
    await _controller.forward();

    // 3) Оповещаем о завершении
    widget.onAnimationComplete?.call();
  }



  void _resetAnimation() {
    _controller.reset();
  }

  @override
  void dispose() {
    if (widget.controller._state == this) {
      widget.controller._state = null;
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_animation.value${_animation.value}');
    return Stack(
      children: [
        // The main content that will be revealed
        widget.child,

        // The white overlay that will be clipped away
        Material(
          color: Colors.transparent,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              if (_animation.value >= 0.4) {
                return const SizedBox.shrink();
              }
              return AbsorbPointer(
                absorbing: _animation.value < 2.0,
                child: ClipPath(
                  clipper: DiamondRevealClipper(
                    revealPercent: _animation.value,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: widget.overlayColor,
                    // Added logo and loading indicator
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Custom App Logo
                        const Spacer(),
                        SizedBox(
                          height: 500,
                          child: Column(
                            children: [
                              AnimatedBuilder(
                                animation: _animation,
                                child: Stack(
                                  children: [
                                    Lottie.asset('assets/json/ailogo.json'),
                                    Positioned(
                                      top: 220,
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          WavyShimmerText(
                                            text: 'NOMIX',
                                            style: AppTypography.rubik40.bold,
                                            duration: Duration(seconds: 2),
                                          ),
                                          WavyShimmerText(
                                            text: 'AI',
                                            style: AppTypography.rubik40.copyWith(fontSize: 30),
                                            duration: Duration(seconds: 2),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                builder: (context, child) {
                                  // Когда _animation.value от 0 до 0.1 – opacity от 1 до 0
                                  final opacity =
                                      (_animation.value < 0.1) ? (1 - _animation.value / 0.1).clamp(0.0, 1.0) : 0.0;
                                  return Opacity(
                                    opacity: opacity,
                                    child: child,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // App Name
                        const Text(
                          'Система отслеживание рассходов  ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 155, 155, 155),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SplashRevealController {
  _SplashRevealWidgetState? _state;
  bool _isAnimating = false;

  Future<void> startReveal() async {
    if (_state != null && !_isAnimating) {
      _isAnimating = true;
      await Future.delayed(Duration(seconds: 1));
      await _state!._startAnimation();
      _isAnimating = false;
    }
  }

  void reset() {
    if (_state != null) {
      _state!._resetAnimation();
    }
  }

  bool get isAnimating => _isAnimating;
}
