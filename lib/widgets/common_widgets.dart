import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';

/// Opens a URL (http/https/mailto/tel) in the appropriate handler.
Future<void> launchUrlSafely(String url) async {
  final uri = Uri.parse(url);
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    // Ignore — nothing useful we can do if the platform has no handler.
  }
}

/// Primary call-to-action button with a gradient fill (or outline variant)
/// and a soft hover-scale / glow effect on web & desktop.
class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool outlined;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.outlined = false,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _hovering ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            decoration: BoxDecoration(
              gradient: widget.outlined ? null : AppColors.primaryGradient,
              color: widget.outlined ? Colors.transparent : null,
              border: widget.outlined
                  ? Border.all(color: AppColors.primary, width: 1.4)
                  : null,
              borderRadius: BorderRadius.circular(14),
              boxShadow: (_hovering && !widget.outlined)
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: 18, color: AppColors.textPrimary),
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.label,
                  style: AppTextStyles.body(
                    size: 15,
                    weight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A small pill "tag" + big title + optional subtitle, used at the top of
/// every screen for a consistent look.
class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;
  final bool center;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Text(
            tag.toUpperCase(),
            style: AppTextStyles.body(
              size: 12,
              weight: FontWeight.w600,
              color: AppColors.primary,
            ).copyWith(letterSpacing: 1.2),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: AppTextStyles.heading(size: 32),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              subtitle!,
              textAlign: center ? TextAlign.center : TextAlign.start,
              style: AppTextStyles.body(size: 16),
            ),
          ),
        ],
      ],
    );
  }
}

/// Row of circular social icon buttons (GitHub / LinkedIn / Twitter / Email).
class SocialIconsRow extends StatelessWidget {
  final double size;
  const SocialIconsRow({super.key, this.size = 42});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.code, PortfolioData.githubUrl),
      (Icons.business_center, PortfolioData.linkedinUrl),
      (Icons.alternate_email, PortfolioData.twitterUrl),
      (Icons.email, 'mailto:${PortfolioData.email}'),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _SocialIcon(icon: item.$1, url: item.$2, size: size),
              ))
          .toList(),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final double size;
  const _SocialIcon({required this.icon, required this.url, required this.size});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => launchUrlSafely(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovering ? AppColors.primary.withOpacity(0.18) : AppColors.surface,
            border: Border.all(
              color: _hovering ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Icon(
            widget.icon,
            size: widget.size * 0.42,
            color: _hovering ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

/// Footer shown at the bottom of every screen.
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          const SocialIconsRow(size: 38),
          const SizedBox(height: 18),
          Text(
            '\u00a9 ${DateTime.now().year} ${PortfolioData.name} \u2014 Built with Flutter',
            style: AppTextStyles.body(size: 13, color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// A code-only abstract avatar illustration (no image assets required).
class AvatarIllustration extends StatelessWidget {
  final double size;
  const AvatarIllustration({super.key, this.size = 260});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 60,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
          Container(
            width: size * 0.86,
            height: size * 0.86,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
              border: Border.all(color: AppColors.surfaceLight, width: 2),
            ),
            child: Icon(
              Icons.flutter_dash,
              size: size * 0.46,
              color: AppColors.primary,
            ),
          ),
          Positioned(
            bottom: size * 0.04,
            right: size * 0.04,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentTeal,
                border: Border.all(color: AppColors.background, width: 3),
              ),
              child: const Icon(Icons.code, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
