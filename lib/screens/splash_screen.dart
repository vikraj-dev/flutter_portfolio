import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _dotsController;

  late Animation<double> _fade;
  late Animation<double> _slideUp;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _slideUp = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat();

    _mainController.forward();

    Future.delayed(const Duration(milliseconds: 5000), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainShell(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _mainController,
          builder: (context, _) {
            return Opacity(
              opacity: _fade.value.clamp(0.0, 1.0),
              child: Transform.translate(
                offset: Offset(0, _slideUp.value),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Name ──
                    Text(
                      PortfolioData.name,
                      style: AppTextStyles.heading(
                        size: 24,
                        weight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // ── Role ──
                    Text(
                      'Flutter Developer',
                      style: AppTextStyles.body(
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // ── Tagline ──
                    Text(
                      'Building beautiful experiences ✨',
                      style: AppTextStyles.body(
                        size: 12,
                        color: AppColors.textMuted,
                      ),
                    ),

                    const SizedBox(height: 36),

                    // ── Dots Loading Animation ──
                    _DotsLoader(controller: _dotsController),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── Animated Dots Widget ──
class _DotsLoader extends StatelessWidget {
  final AnimationController controller;

  const _DotsLoader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final double offset = (controller.value + index * 0.33) % 1.0;
            final double bounce =
                offset < 0.5 ? offset * 2 : (1.0 - offset) * 2;
            final double translateY = -8 * bounce;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Transform.translate(
                offset: Offset(0, translateY),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.4 + 0.6 * bounce),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}