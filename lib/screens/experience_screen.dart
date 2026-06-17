import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../utils/responsive.dart';
import '../widgets/animated_widgets.dart';
import '../widgets/common_widgets.dart';
import '../widgets/card_widgets.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.horizontalPadding(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(hPad, 60, hPad, 60),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FadeSlideIn(
                    child: SectionHeader(
                      tag: 'Career Path',
                      title: 'My experience & education',
                      subtitle: 'A timeline of where I have worked, studied and grown as a developer.',
                    ),
                  ),
                  const SizedBox(height: 46),
                  ...List.generate(PortfolioData.experience.length, (i) {
                    final isLast = i == PortfolioData.experience.length - 1;
                    return FadeSlideIn(
                      delay: Duration(milliseconds: i * 110),
                      child: TimelineItem(item: PortfolioData.experience[i], isLast: isLast),
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
