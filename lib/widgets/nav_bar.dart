import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../utils/responsive.dart';
import 'common_widgets.dart';

const List<String> kNavLabels = [
  'Home',
  'About',
  'Skills',
  'Projects',
  'Experience',
  'Contact',
];

class TopNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onMenuTap;

  const TopNavBar({
    super.key,
    required this.currentIndex,
    required this.onSelect,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      height: 76,
      padding: EdgeInsets.symmetric(horizontal: Responsive.horizontalPadding(context)),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onSelect(0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.flutter_dash, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  if (!isMobile)
                    Text(
                      PortfolioData.name,
                      style: AppTextStyles.heading(size: 18, weight: FontWeight.w700),
                    ),
                ],
              ),
            ),
          ),
          const Spacer(),
          if (!isMobile)
            Row(
              children: List.generate(kNavLabels.length, (i) {
                return _NavItem(
                  label: kNavLabels[i],
                  selected: currentIndex == i,
                  onTap: () => onSelect(i),
                );
              }),
            ),
          if (!isMobile) const SizedBox(width: 16),
          if (!isMobile)
            GradientButton(label: 'Hire Me', onPressed: () => onSelect(kNavLabels.length - 1))
          else
            IconButton(
              onPressed: onMenuTap,
              icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavItem({required this.label, required this.selected, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.selected || _hovering;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.body(
                  size: 14.5,
                  weight: FontWeight.w600,
                  color: active ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: active ? 20 : 0,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelect;
  const NavDrawer({super.key, required this.currentIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: List.generate(kNavLabels.length, (i) {
            final selected = currentIndex == i;
            return ListTile(
              title: Text(
                kNavLabels[i],
                style: AppTextStyles.body(
                  size: 16,
                  weight: FontWeight.w600,
                  color: selected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              leading: Icon(
                _iconFor(i),
                color: selected ? AppColors.primary : AppColors.textSecondary,
              ),
              onTap: () {
                Navigator.of(context).pop();
                onSelect(i);
              },
            );
          }),
        ),
      ),
    );
  }

  IconData _iconFor(int i) {
    switch (i) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.person;
      case 2:
        return Icons.bolt;
      case 3:
        return Icons.work;
      case 4:
        return Icons.timeline;
      default:
        return Icons.mail;
    }
  }
}
