import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'common_widgets.dart';
import 'effects_3d.dart';

/// A skill name + animated progress bar, wrapped in a subtle 3D tilt card.
class SkillProgressCard extends StatefulWidget {
  final SkillItem skill;
  const SkillProgressCard({super.key, required this.skill});

  @override
  State<SkillProgressCard> createState() => _SkillProgressCardState();
}

class _SkillProgressCardState extends State<SkillProgressCard> {
  bool _started = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _started = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Tilt3DCard(
      maxTilt: 0.05,
      builder: (hovering) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hovering ? AppColors.primary.withOpacity(0.5) : AppColors.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.skill.icon, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.skill.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body(
                        size: 15,
                        weight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.skill.level}%',
                    style: AppTextStyles.body(size: 13, color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Container(height: 8, width: constraints.maxWidth, color: AppColors.surfaceLight),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.easeOutCubic,
                          height: 8,
                          width: _started ? constraints.maxWidth * (widget.skill.level / 100) : 0,
                          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A project showcase card with a real-time 3D mouse-tilt on hover.
class ProjectCard extends StatelessWidget {
  final ProjectItem project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final p = project;
    return Tilt3DCard(
      builder: (hovering) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: hovering ? AppColors.primary.withOpacity(0.6) : AppColors.border,
            ),
            boxShadow: hovering
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 18),
                    ),
                  ]
                : [],
          ),
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: p.gradient),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(p.icon, color: Colors.white, size: 26),
              ),
              const SizedBox(height: 18),
              Text(
                p.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body(
                  size: 18,
                  weight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                p.description,
                style: AppTextStyles.body(size: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: p.techStack
                    .map((t) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            t,
                            style: AppTextStyles.body(size: 11.5, color: AppColors.textSecondary),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  if (p.githubUrl.isNotEmpty)
                    Expanded(
                      child: _CardLinkButton(
                        label: 'Code',
                        icon: Icons.code,
                        onTap: () => launchUrlSafely(p.githubUrl),
                      ),
                    ),
                  if (p.githubUrl.isNotEmpty && p.liveUrl.isNotEmpty) const SizedBox(width: 10),
                  if (p.liveUrl.isNotEmpty)
                    Expanded(
                      child: _CardLinkButton(
                        label: 'Live Demo',
                        icon: Icons.open_in_new,
                        onTap: () => launchUrlSafely(p.liveUrl),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CardLinkButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _CardLinkButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(label, style: AppTextStyles.body(size: 12.5, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single entry on the vertical Experience / Education timeline.
class TimelineItem extends StatelessWidget {
  final ExperienceItem item;
  final bool isLast;
  const TimelineItem({super.key, required this.item, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final dotColor = item.isEducation ? AppColors.accentTeal : AppColors.primary;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dotColor,
                  boxShadow: [
                    BoxShadow(color: dotColor.withOpacity(0.5), blurRadius: 12, spreadRadius: 2),
                  ],
                ),
              ),
              if (!isLast) Expanded(child: Container(width: 2, color: AppColors.border)),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        Text(
                          item.role,
                          style: AppTextStyles.body(
                            size: 17,
                            weight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.duration,
                            style: AppTextStyles.body(size: 12, color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.company,
                      style: AppTextStyles.body(size: 14, color: AppColors.accentTeal),
                    ),
                    const SizedBox(height: 10),
                    Text(item.description, style: AppTextStyles.body(size: 14)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
