import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../utils/responsive.dart';
import '../widgets/animated_widgets.dart';
import '../widgets/common_widgets.dart';
import '../widgets/card_widgets.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _filter = 'All';

  List<String> get _categories {
    final set = <String>{'All'};
    for (final p in PortfolioData.projects) {
      set.add(p.category);
    }
    return set.toList();
  }

  List<ProjectItem> get _filtered {
    if (_filter == 'All') return PortfolioData.projects;
    return PortfolioData.projects.where((p) => p.category == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.contentMaxWidth(context);
    final hPad = Responsive.horizontalPadding(context);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

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
                      tag: 'Portfolio',
                      title: 'Things I have built',
                      subtitle: 'A selection of apps and experiments \u2014 hover a card to see the 3D tilt effect.',
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 100),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _categories.map((c) => _FilterChip(
                            label: c,
                            selected: _filter == c,
                            onTap: () => setState(() => _filter = c),
                          )).toList(),
                    ),
                  ),
                  const SizedBox(height: 36),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filtered.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                      mainAxisExtent: 460,
                    ),
                    itemBuilder: (context, i) {
                      return ProjectCard(project: _filtered[i]);
                    },
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
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selected ? AppColors.primary : AppColors.border),
          ),
          child: Text(
            label,
            style: AppTextStyles.body(
              size: 13.5,
              weight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
