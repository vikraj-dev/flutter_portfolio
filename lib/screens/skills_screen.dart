import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../utils/responsive.dart';
import '../widgets/animated_widgets.dart';
import '../widgets/common_widgets.dart';
import '../widgets/card_widgets.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.contentMaxWidth(context);
    final hPad = Responsive.horizontalPadding(context);
    final crossAxisCount = Responsive.isMobile(context) ? 1 : 2;

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
                      tag: 'My Skills',
                      title: 'Technologies I work with',
                      subtitle: 'A snapshot of the tools and frameworks I use to build polished apps.',
                    ),
                  ),
                  const SizedBox(height: 46),
                  ...List.generate(PortfolioData.skillGroups.length, (gIndex) {
                    final group = PortfolioData.skillGroups[gIndex];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: FadeSlideIn(
                        delay: Duration(milliseconds: gIndex * 90),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              group.title,
                              style: AppTextStyles.heading(size: 18, weight: FontWeight.w700),
                            ),
                            const SizedBox(height: 18),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: group.skills.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                mainAxisExtent: 120,
                              ),
                              itemBuilder: (context, i) {
                                return SkillProgressCard(skill: group.skills[i]);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        const AppFooter(),
      ],
    );
  }
}
