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
  final ScrollController _scrollController = ScrollController();

  void _select(int i) {
    if (_index == i) return; // same screen tap பண்ணா skip
    setState(() => _index = i);
    // புது screen போகும்போது top-க்கு scroll
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    });
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: isMobile
          ? NavDrawer(currentIndex: _index, onSelect: _select)
          : null,
      body: Column(
        children: [
          TopNavBar(
            currentIndex: _index,
            onSelect: _select,
            onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                final fadeAnim = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                );
                final slideAnim = Tween<Offset>(
                  begin: const Offset(0, 0.015), // subtle slide
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ));
                return FadeTransition(
                  opacity: fadeAnim,
                  child: SlideTransition(
                    position: slideAnim,
                    child: RepaintBoundary(child: child), // lag reduce
                  ),
                );
              },
              child: SingleChildScrollView(
                key: ValueKey(_index),
                controller: _scrollController,
                physics: const BouncingScrollPhysics(), // smooth scroll
                child: RepaintBoundary(
                  child: _buildScreen(_index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}