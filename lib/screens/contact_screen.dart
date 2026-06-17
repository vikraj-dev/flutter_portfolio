import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../utils/responsive.dart';
import '../widgets/animated_widgets.dart';
import '../widgets/common_widgets.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (!_formKey.currentState!.validate()) return;

    final subject = Uri.encodeComponent('Portfolio enquiry from ${_nameController.text}');
    final body = Uri.encodeComponent(
      'Name: ${_nameController.text}\nEmail: ${_emailController.text}\n\n${_messageController.text}',
    );
    launchUrlSafely('mailto:${PortfolioData.email}?subject=$subject&body=$body');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Opening your email app to send the message...'),
        backgroundColor: AppColors.surfaceLight,
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTextStyles.body(size: 14, color: AppColors.textMuted),
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
      ),
    );
  }

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
                  FadeSlideIn(
                    child: SectionHeader(
                      tag: "Let's Talk",
                      title: 'Get in touch',
                      subtitle: 'Have a project in mind or just want to say hi? My inbox is always open.',
                      center: isMobile,
                    ),
                  ),
                  const SizedBox(height: 46),
                  isMobile
                      ? Column(
                          children: [
                            FadeSlideIn(delay: const Duration(milliseconds: 100), child: _infoColumn()),
                            const SizedBox(height: 36),
                            FadeSlideIn(delay: const Duration(milliseconds: 180), child: _formCard()),
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
                                  child: _infoColumn(),
                                ),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                flex: 6,
                                child: FadeSlideIn(
                                  delay: const Duration(milliseconds: 180),
                                  child: _formCard(),
                                ),
                              ),
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

  Widget _infoColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactInfoCard(icon: Icons.email, title: 'Email', value: PortfolioData.email),
        const SizedBox(height: 18),
        _ContactInfoCard(icon: Icons.phone, title: 'Phone', value: PortfolioData.phone),
        const SizedBox(height: 18),
        _ContactInfoCard(icon: Icons.location_on, title: 'Location', value: PortfolioData.location),
        const SizedBox(height: 28),
        Text(
          'Find me online',
          style: AppTextStyles.body(size: 14, weight: FontWeight.w600, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 14),
        const SocialIconsRow(),
      ],
    );
  }

  Widget _formCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              style: AppTextStyles.body(size: 14.5, color: AppColors.textPrimary),
              decoration: _decoration('Your Name'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: _emailController,
              style: AppTextStyles.body(size: 14.5, color: AppColors.textPrimary),
              decoration: _decoration('Your Email'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Please enter your email';
                if (!v.contains('@')) return 'Please enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              style: AppTextStyles.body(size: 14.5, color: AppColors.textPrimary),
              decoration: _decoration('Your Message'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a message' : null,
            ),
            const SizedBox(height: 24),
            GradientButton(label: 'Send Message', icon: Icons.send, onPressed: _sendMessage),
          ],
        ),
      ),
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _ContactInfoCard({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body(size: 12.5, color: AppColors.textMuted)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTextStyles.body(size: 14.5, weight: FontWeight.w600, color: AppColors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
