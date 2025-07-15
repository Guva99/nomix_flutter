import 'package:flutter/material.dart';

class CollapseAnimatedBox extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final bool isCollapse;

  const CollapseAnimatedBox({
    Key? key,
    this.duration = const Duration(milliseconds: 250),
    required this.isCollapse,
    required this.child,
  }) : super(key: key);

  @override
  _CollapseAnimatedBoxState createState() => _CollapseAnimatedBoxState();
}

class _CollapseAnimatedBoxState extends State<CollapseAnimatedBox>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    if (!widget.isCollapse) {
      _animationController.value = 1;
    }
  }

  @override
  void didUpdateWidget(CollapseAnimatedBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isCollapse == widget.isCollapse) return;

    if (widget.isCollapse) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) => SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
      axisAlignment: 1.0,
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animationController,
          curve: Curves.linear,
        ),
        child: widget.child,
      ),
    );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}