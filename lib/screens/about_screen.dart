import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../utils/responsive.dart';
import '../widgets/animated_widgets.dart';
import '../widgets/effects_3d.dart';
import '../widgets/common_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final maxWidth = Responsive.contentMaxWidth(context);
    final hPad = Responsive.horizontalPadding(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(hPad, 60, hPad, 60),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FadeSlideIn(
                    child: SectionHeader(
                      tag: 'About Me',
                      title: 'Turning ideas into smooth Flutter experiences',
                    ),
                  ),
                  const SizedBox(height: 50),
                  isMobile
                      ? Column(
                          children: [
                            FadeSlideIn(
                              delay: const Duration(milliseconds: 100),
                              child: _infoCard(),
                            ),
                            const SizedBox(height: 36),
                            _bioColumn(isMobile: true),
                          ],
                        )
                      : IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: FadeSlideIn(
                                  delay: const Duration(milliseconds: 100),
                                  child: _infoCard(),
                                ),
                              ),
                              const SizedBox(width: 40),
                              Expanded(flex: 6, child: _bioColumn(isMobile: false)),
                            ],
                          ),
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

  Widget _infoCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // ✅ AvatarIllustration போச்சு, real photo வந்துச்சு
          Floating3D(
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 30,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: Image.asset(
                    'assets/crop.JPG',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 64,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            PortfolioData.name,
            style: AppTextStyles.heading(size: 20, weight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            'Flutter Developer',
            style: AppTextStyles.body(size: 14, color: AppColors.primary),
          ),
          const SizedBox(height: 24),
          _infoRow(Icons.email, PortfolioData.email),
          const SizedBox(height: 14),
          _infoRow(Icons.location_on, PortfolioData.location),
          const SizedBox(height: 14),
          _infoRow(Icons.check_circle, 'Available for freelance work'),
          const SizedBox(height: 24),
          GradientButton(
            label: 'Download Resume',
            icon: Icons.download,
            onPressed: () => launchUrlSafely(PortfolioData.resumeUrl),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.body(size: 13.5),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _bioColumn({required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        FadeSlideIn(
          delay: const Duration(milliseconds: 160),
          child: Text(
            PortfolioData.longBio,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: AppTextStyles.body(size: 16),
          ),
        ),
        const SizedBox(height: 30),
        FadeSlideIn(
          delay: const Duration(milliseconds: 220),
          child: Wrap(
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            spacing: 18,
            runSpacing: 18,
            children: [
              _highlightCard(
                Icons.rocket_launch,
                '${PortfolioData.projectsCompleted}+ Projects',
                'Shipped to production',
                'Each one tested with real users and lots of coffee ☕',
              ),
              _highlightCard(
                Icons.schedule,
                '${PortfolioData.yearsExperience}+ Years',
                'Building with Flutter',
                'Started with Hello World, now shipping production apps 🚀',
              ),
              _highlightCard(
                Icons.star,
                'Pixel Perfect',
                'UI/UX focused',
                'I obsess over animations running at a buttery 60fps ✨',
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        FadeSlideIn(
          delay: const Duration(milliseconds: 260),
          child: Text(
            'Hover or tap a card to flip it →',
            style: AppTextStyles.body(size: 12.5, color: AppColors.textMuted),
          ),
        ),
        const SizedBox(height: 30),
        FadeSlideIn(
          delay: const Duration(milliseconds: 320),
          child: Text(
            'Achievements',
            style: AppTextStyles.heading(size: 20, weight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 16),
        // ✅ உன் real achievements மட்டும்
        ...List.generate(PortfolioData.achievements.length, (i) {
          return FadeSlideIn(
            delay: Duration(milliseconds: 360 + i * 70),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(
                      Icons.check_circle,
                      size: 16,
                      color: AppColors.accentTeal,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      PortfolioData.achievements[i],
                      style: AppTextStyles.body(size: 14.5),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _highlightCard(
      IconData icon, String title, String subtitle, String funFact) {
    return SizedBox(
      width: 190,
      height: 130,
      child: Flip3DCard(
        front: _highlightFace(icon: icon, title: title, subtitle: subtitle),
        back: _highlightFaceBack(funFact),
      ),
    );
  }

  Widget _highlightFace(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return Container(
      width: 190,
      height: 130,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 26),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.body(
                size: 15,
                weight: FontWeight.w700,
                color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: AppTextStyles.body(size: 12.5)),
        ],
      ),
    );
  }

  Widget _highlightFaceBack(String funFact) {
    return Container(
      width: 190,
      height: 130,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Text(
        funFact,
        textAlign: TextAlign.center,
        style: AppTextStyles.body(
            size: 12.5, color: Colors.white, weight: FontWeight.w600),
      ),
    );
  }
}