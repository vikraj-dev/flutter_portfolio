import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/nav_bar.dart';
import 'home_screen.dart';
import 'about_screen.dart';
import 'skills_screen.dart';
import 'projects_screen.dart';
import 'experience_screen.dart';
import 'contact_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _select(int i) {
    setState(() => _index = i);
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen(onNavigate: _select);
      case 1:
        return const AboutScreen();
      case 2:
        return const SkillsScreen();
      case 3:
        return const ProjectsScreen();
      case 4:
        return const ExperienceScreen();
      default:
        return const ContactScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: isMobile ? NavDrawer(currentIndex: _index, onSelect: _select) : null,
      body: Column(
        children: [
          TopNavBar(
            currentIndex: _index,
            onSelect: _select,
            onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) {
                final slide = Tween<Offset>(
                  begin: const Offset(0, 0.03),
                  end: Offset.zero,
                ).animate(animation);
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(position: slide, child: child),
                );
              },
              child: SingleChildScrollView(
                key: ValueKey(_index),
                child: _buildScreen(_index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
