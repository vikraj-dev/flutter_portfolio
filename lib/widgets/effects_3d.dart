import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ---------------------------------------------------------------------------
/// 3D EFFECTS
/// Lightweight, pure-Flutter pseudo-3D effects (perspective Matrix4 transforms).
/// No external packages or 3D model files needed.
/// ---------------------------------------------------------------------------

/// Wraps any card with a real-time mouse-tracking 3D tilt + perspective.
/// Move your mouse over the card on web/desktop and it tilts towards the
/// cursor, like a glossy Awwwards-style card.
class Tilt3DCard extends StatefulWidget {
  final Widget Function(bool hovering) builder;
  final double maxTilt;

  const Tilt3DCard({super.key, required this.builder, this.maxTilt = 0.10});

  @override
  State<Tilt3DCard> createState() => _Tilt3DCardState();
}

class _Tilt3DCardState extends State<Tilt3DCard> {
  double _rotateX = 0;
  double _rotateY = 0;
  bool _hovering = false;

  void _onHover(PointerHoverEvent event, BoxConstraints constraints) {
    final w = constraints.maxWidth;
    final h = constraints.maxHeight;
    if (w <= 0 || h <= 0) return;
    final dx = (event.localPosition.dx / w) - 0.5;
    final dy = (event.localPosition.dy / h) - 0.5;
    setState(() {
      _rotateY = dx * widget.maxTilt * 2;
      _rotateX = -dy * widget.maxTilt * 2;
      _hovering = true;
    });
  }

  void _onExit() {
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
      _hovering = false;
    });
  }

  Matrix4 _buildTransform() {
    final perspective = Matrix4.identity()..setEntry(3, 2, 0.0012);
    final scaleValue = _hovering ? 1.025 : 1.0;
    return perspective *
        Matrix4.rotationX(_rotateX) *
        Matrix4.rotationY(_rotateY) *
        Matrix4.diagonal3Values(scaleValue, scaleValue, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (e) => _onHover(e, constraints),
          onExit: (_) => _onExit(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            transformAlignment: Alignment.center,
            transform: _buildTransform(),
            child: widget.builder(_hovering),
          ),
        );
      },
    );
  }
}

/// Makes its child gently rock back and forth in 3D space, like it's
/// floating — used on the avatar / hero illustration.
class Floating3D extends StatefulWidget {
  final Widget child;
  const Floating3D({super.key, required this.child});

  @override
  State<Floating3D> createState() => _Floating3DState();
}

class _Floating3DState extends State<Floating3D> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat();
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
      builder: (context, child) {
        final t = _controller.value * 2 * math.pi;
        final rotY = math.sin(t) * 0.18;
        final rotX = math.cos(t * 0.8) * 0.10;
        final floatY = math.sin(t) * 8;

        final perspective = Matrix4.identity()..setEntry(3, 2, 0.0012);
        final transform = perspective * Matrix4.rotationX(rotX) * Matrix4.rotationY(rotY);

        return Transform.translate(
          offset: Offset(0, floatY),
          child: Transform(
            alignment: Alignment.center,
            transform: transform,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// A tap / hover-to-flip 3D card with a front and back face. The face that
/// isn't currently visible is swapped out at the 90-degree mark so there is
/// never any visual overlap glitch — a classic, reliable Flutter technique.
class Flip3DCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  const Flip3DCard({super.key, required this.front, required this.back});

  @override
  State<Flip3DCard> createState() => _Flip3DCardState();
}

class _Flip3DCardState extends State<Flip3DCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showingFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showBack() {
    if (!_showingFront) return;
    _showingFront = false;
    _controller.forward();
  }

  void _showFront() {
    if (_showingFront) return;
    _showingFront = true;
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _showBack(),
      onExit: (_) => _showFront(),
      child: GestureDetector(
        onTap: () => _showingFront ? _showBack() : _showFront(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final angle = _controller.value * math.pi;
            final isBack = angle > math.pi / 2;
            final displayAngle = isBack ? angle - math.pi : angle;
            final perspective = Matrix4.identity()..setEntry(3, 2, 0.0015);

            return Transform(
              alignment: Alignment.center,
              transform: perspective * Matrix4.rotationY(displayAngle),
              child: isBack ? widget.back : widget.front,
            );
          },
        ),
      ),
    );
  }
}
