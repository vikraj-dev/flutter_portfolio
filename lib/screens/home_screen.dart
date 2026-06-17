import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../utils/responsive.dart';
import '../widgets/animated_widgets.dart';
import '../widgets/effects_3d.dart';
import '../widgets/common_widgets.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final maxWidth = Responsive.contentMaxWidth(context);
    final hPad = Responsive.horizontalPadding(context);

    return Column(
      children: [
        Stack(
          children: [
            const Positioned.fill(
              child: IgnorePointer(child: AnimatedBlobBackground()),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(hPad, isMobile ? 50 : 70, hPad, isMobile ? 50 : 70),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: isMobile
                      ? Column(
                          children: [
                            _heroText(context, center: true),
                            const SizedBox(height: 50),
                            FadeSlideIn(
                              delay: const Duration(milliseconds: 300),
                              child: Center(
                                child: Floating3D(child: AvatarIllustration(size: 220)),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(flex: 6, child: _heroText(context, center: false)),
                            const SizedBox(width: 40),
                            Expanded(
                              flex: 4,
                              child: FadeSlideIn(
                                delay: const Duration(milliseconds: 250),
                                child: Center(
                                  child: Floating3D(child: AvatarIllustration(size: 300)),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 36),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 24,
                children: [
                  SizedBox(
                    width: isMobile ? 140 : 200,
                    child: StatCounter(value: PortfolioData.yearsExperience, label: 'Years Experience'),
                  ),
                  SizedBox(
                    width: isMobile ? 140 : 200,
                    child: StatCounter(value: PortfolioData.projectsCompleted, label: 'Projects Completed'),
                  ),
                  SizedBox(
                    width: isMobile ? 140 : 200,
                    child: StatCounter(value: PortfolioData.happyClients, label: 'Happy Clients'),
                  ),
                  SizedBox(
                    width: isMobile ? 140 : 200,
                    child: StatCounter(value: PortfolioData.appsPublished, label: 'Apps Published'),
                  ),
                ],
              ),
            ),
          ),
        ),
        const AppFooter(),
      ],
    );
  }

  Widget _heroText(BuildContext context, {required bool center}) {
    final isMobile = Responsive.isMobile(context);
    return Column(
      crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        FadeSlideIn(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accentTeal.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.accentTeal.withOpacity(0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentTeal,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Available for new projects',
                  style: AppTextStyles.body(
                    size: 12.5,
                    weight: FontWeight.w600,
                    color: AppColors.accentTeal,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 22),
        FadeSlideIn(
          delay: const Duration(milliseconds: 80),
          child: Text(
            "Hi, I'm ${PortfolioData.name}",
            textAlign: center ? TextAlign.center : TextAlign.start,
            style: AppTextStyles.heading(size: isMobile ? 32 : 46),
          ),
        ),
        const SizedBox(height: 12),
        FadeSlideIn(
          delay: const Duration(milliseconds: 180),
          child: Wrap(
            alignment: center ? WrapAlignment.center : WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'I build ',
                style: AppTextStyles.heading(size: isMobile ? 20 : 26, color: AppColors.textSecondary),
              ),
              TypewriterText(
                texts: PortfolioData.roles,
                style: AppTextStyles.heading(size: isMobile ? 20 : 26, color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FadeSlideIn(
          delay: const Duration(milliseconds: 260),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Text(
              PortfolioData.shortBio,
              textAlign: center ? TextAlign.center : TextAlign.start,
              style: AppTextStyles.body(size: 16),
            ),
          ),
        ),
        const SizedBox(height: 28),
        FadeSlideIn(
          delay: const Duration(milliseconds: 340),
          child: Wrap(
            alignment: center ? WrapAlignment.center : WrapAlignment.start,
            spacing: 14,
            runSpacing: 14,
            children: [
              GradientButton(
                label: 'View My Work',
                icon: Icons.arrow_forward,
                onPressed: () => onNavigate(3),
              ),
              GradientButton(
                label: 'Contact Me',
                outlined: true,
                onPressed: () => onNavigate(5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        FadeSlideIn(
          delay: const Duration(milliseconds: 420),
          child: const SocialIconsRow(),
        ),
      ],
    );
  }
}
