import 'package:flutter/material.dart';

//Пока нр
class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final List<Color> colors;
  final Duration duration;

  const AnimatedGradientText({
    Key? key,
    required this.text,
    required this.style,
    required this.colors,
    this.duration = const Duration(seconds: 4),
  }) : super(key: key);

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(); // бесконечный цикл
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Text(
        widget.text,
        style: widget.style.copyWith(color: Colors.white),
      ),
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            final width = bounds.width;
            final height = bounds.height;

            // Градиент, повторяющийся по горизонтали
            final gradient = LinearGradient(
              colors: widget.colors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.repeated,
            );

             final slide = _controller.value * width;

            final rect = Rect.fromLTWH(
              bounds.left - slide,
              bounds.top,
              width,
              height,
            );

            return gradient.createShader(rect);
          },
          child: child,
        );
      },
    );
  }
}
