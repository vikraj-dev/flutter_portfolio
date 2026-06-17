import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Plays a fade + slide-up entrance animation for its child once it mounts.
/// Wrap any widget with this to make it "appear" smoothly instead of popping
/// onto the screen instantly. Use `delay` to stagger a list of items.
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offsetY;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.offsetY = 28,
  });

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _slideY;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideY = Tween<double>(begin: widget.offsetY, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _timer = Timer(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fade.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, _slideY.value),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Cycles through a list of strings with a classic typewriter
/// type-then-delete effect. Used for the rotating job-title text on Home.
class TypewriterText extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration typingSpeed;
  final Duration pause;

  const TypewriterText({
    super.key,
    required this.texts,
    this.style,
    this.typingSpeed = const Duration(milliseconds: 80),
    this.pause = const Duration(milliseconds: 1500),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayed = '';
  int _textIndex = 0;
  int _charIndex = 0;
  bool _deleting = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.texts.isNotEmpty) {
      _scheduleNext(widget.typingSpeed);
    }
  }

  void _scheduleNext(Duration after) {
    _timer = Timer(after, _step);
  }

  void _step() {
    if (!mounted || widget.texts.isEmpty) return;
    final currentText = widget.texts[_textIndex];

    setState(() {
      if (!_deleting) {
        _charIndex++;
        _displayed = currentText.substring(0, _charIndex);
      } else {
        _charIndex--;
        _displayed = currentText.substring(0, _charIndex);
      }
    });

    if (!_deleting && _charIndex >= currentText.length) {
      _deleting = true;
      _scheduleNext(widget.pause);
    } else if (_deleting && _charIndex <= 0) {
      _deleting = false;
      _textIndex = (_textIndex + 1) % widget.texts.length;
      _scheduleNext(widget.typingSpeed);
    } else {
      _scheduleNext(widget.typingSpeed);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_displayed|', style: widget.style);
  }
}

/// Animates an integer counting up from 0 to [value] — used for the
/// "Years experience / Projects completed" style stats on the Home screen.
class StatCounter extends StatelessWidget {
  final int value;
  final String label;
  final String suffix;
  final Duration duration;

  const StatCounter({
    super.key,
    required this.value,
    required this.label,
    this.suffix = '+',
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, val, child) {
        return Column(
          children: [
            Text(
              '$val$suffix',
              style: AppTextStyles.heading(size: 34, color: AppColors.primary),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.body(size: 13.5),
            ),
          ],
        );
      },
    );
  }
}

/// A soft, continuously-drifting gradient-blob backdrop. Wrap with
/// `Positioned.fill(child: IgnorePointer(child: AnimatedBlobBackground()))`
/// inside a Stack so it sits behind your real content without blocking taps.
class AnimatedBlobBackground extends StatefulWidget {
  const AnimatedBlobBackground({super.key});

  @override
  State<AnimatedBlobBackground> createState() => _AnimatedBlobBackgroundState();
}

class _AnimatedBlobBackgroundState extends State<AnimatedBlobBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 14))
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
      builder: (context, _) {
        final t = _controller.value * 2 * math.pi;
        return Stack(
          children: [
            _blob(
              top: 80 + 30 * math.sin(t),
              left: -100 + 40 * math.cos(t),
              size: 320,
              colors: [AppColors.primary.withOpacity(0.32), Colors.transparent],
            ),
            _blob(
              top: 300 + 40 * math.cos(t),
              right: -120 + 30 * math.sin(t),
              size: 380,
              colors: [AppColors.secondary.withOpacity(0.28), Colors.transparent],
            ),
            _blob(
              bottom: 60 + 25 * math.sin(t + 1),
              left: 100 + 30 * math.cos(t + 1),
              size: 260,
              colors: [AppColors.accentTeal.withOpacity(0.20), Colors.transparent],
            ),
          ],
        );
      },
    );
  }

  Widget _blob({
    double? top,
    double? left,
    double? right,
    double? bottom,
    required double size,
    required List<Color> colors,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: colors),
        ),
      ),
    );
  }
}
