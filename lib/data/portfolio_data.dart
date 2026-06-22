import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// PORTFOLIO DATA
/// This is the ONLY file you need to edit to make this portfolio your own.
/// Replace the placeholder text, links and lists below with your real info.
/// ---------------------------------------------------------------------------

class SkillItem {
  final String name;
  final IconData icon;
  final int level; // 0-100
  const SkillItem({required this.name, required this.icon, required this.level});
}

class SkillGroup {
  final String title;
  final List<SkillItem> skills;
  const SkillGroup({required this.title, required this.skills});
}

class ProjectItem {
  final String title;
  final String category; // Mobile App, Web App, UI/UX
  final String description;
  final List<String> techStack;
  final IconData icon;
  final List<Color> gradient;
  final String githubUrl;
  final String liveUrl;
  const ProjectItem({
    required this.title,
    required this.category,
    required this.description,
    required this.techStack,
    required this.icon,
    required this.gradient,
    this.githubUrl = '',
    this.liveUrl = '',
  });
}

class ExperienceItem {
  final String role;
  final String company;
  final String duration;
  final String description;
  final bool isEducation;
  const ExperienceItem({
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
    this.isEducation = false,
  });
}

class PortfolioData {
  // ---- Basic info — EDIT THESE ----
  static const String name = 'Vikraj.A';
  static const String shortBio =
      "I'm a passionate Flutter Developer who loves turning ideas into smooth, "
      'pixel-perfect mobile and web experiences.';
  static const String longBio =
      "I build cross-platform apps with Flutter & Dart, focusing on clean "
      "architecture, smooth animations and delightful UI/UX. Over the years "
      "I've shipped apps used by thousands of users, worked closely with "
      "designers, and turned Figma files into production-ready Flutter code.";

  static const List<String> roles = [
    'Flutter Developer',
    'Mobile App Engineer',
    'UI/UX Enthusiast',
    'Cross-Platform Specialist',
  ];

  static const String email = 'vikrajarjun@gmail.com';
  static const String phone = '+91 63801 77563';
  static const String location = 'Coimbatore, Tamil Nadu, India';

  static const String githubUrl = 'https://github.com/vikraj-dev';
  static const String linkedinUrl = 'https://www.linkedin.com/in/vikraj-arjun/';
  static const String instagramUrl = 'https://instagram.com/itsvicky.dev'; 
  static const String resumeUrl = 'https://github.com/yourusername';

  // ---- Stats shown on the Home screen ----
  static const int yearsExperience = 2;
  static const int projectsCompleted = 6;
  static const int happyClients = 3;
  static const int appsPublished = 2;

  // ---- Skills ----
  static const List<SkillGroup> skillGroups = [
    SkillGroup(title: 'Languages & Frameworks', skills: [
      SkillItem(name: 'Flutter', icon: Icons.flutter_dash, level: 95),
      SkillItem(name: 'Dart', icon: Icons.code, level: 92),
      SkillItem(name: 'REST API Integration', icon: Icons.api, level: 88),
      SkillItem(name: 'Firebase', icon: Icons.local_fire_department, level: 85),
    ]),
    SkillGroup(title: 'State Management', skills: [
      SkillItem(name: 'Provider', icon: Icons.account_tree, level: 90),
      SkillItem(name: 'GetX', icon: Icons.bolt, level: 88),
      SkillItem(name: 'Bloc / Cubit', icon: Icons.layers, level: 80),
      SkillItem(name: 'Riverpod', icon: Icons.water_drop, level: 75),
    ]),
    SkillGroup(title: 'Backend & Database', skills: [
      SkillItem(name: 'Firebase Firestore', icon: Icons.cloud, level: 87),
      SkillItem(name: 'SQLite / Hive', icon: Icons.storage, level: 82),
      SkillItem(name: 'Node.js (basic)', icon: Icons.dns, level: 60),
      SkillItem(name: 'Supabase', icon: Icons.flash_on, level: 70),
    ]),
    SkillGroup(title: 'Tools & Design', skills: [
      SkillItem(name: 'Git & GitHub', icon: Icons.merge_type, level: 90),
      SkillItem(name: 'Figma', icon: Icons.design_services, level: 85),
      SkillItem(name: 'CI/CD', icon: Icons.settings_suggest, level: 70),
      SkillItem(name: 'Android Studio / VS Code', icon: Icons.developer_mode, level: 92),
    ]),
  ];

  // ---- Projects ----
  static const List<ProjectItem> projects = [
    ProjectItem(
      title: 'ShopEase \u2013 E-Commerce App',
      category: 'Mobile App',
      description:
          'A full-featured shopping app with cart, wishlist, payments and an admin panel, built with Flutter & Firebase.',
      techStack: ['Flutter', 'Firebase', 'Provider', 'Razorpay'],
      icon: Icons.shopping_bag,
      gradient: [Color(0xFF4F8CFF), Color(0xFF8B5CF6)],
      githubUrl: 'https://github.com/yourusername/shopease',
    ),
    ProjectItem(
      title: 'FitTrack \u2013 Fitness Companion',
      category: 'Mobile App',
      description:
          'Tracks workouts, calories and progress with beautiful charts and daily reminders.',
      techStack: ['Flutter', 'GetX', 'SQLite', 'fl_chart'],
      icon: Icons.fitness_center,
      gradient: [Color(0xFF13E1C0), Color(0xFF4F8CFF)],
      githubUrl: 'https://github.com/yourusername/fittrack',
    ),
    ProjectItem(
      title: 'ChatSphere \u2013 Realtime Chat',
      category: 'Mobile App',
      description:
          'One-to-one and group messaging app with media sharing, built using a realtime database.',
      techStack: ['Flutter', 'Firebase', 'Bloc'],
      icon: Icons.chat_bubble,
      gradient: [Color(0xFFFF8A65), Color(0xFFFF5C8A)],
      githubUrl: 'https://github.com/yourusername/chatsphere',
    ),
    ProjectItem(
      title: 'Foodie Express',
      category: 'Mobile App',
      description:
          'Food ordering app with live order tracking, ratings and a clean, animated UI.',
      techStack: ['Flutter', 'Riverpod', 'Maps API'],
      icon: Icons.restaurant,
      gradient: [Color(0xFFFFC371), Color(0xFFFF5F6D)],
      githubUrl: 'https://github.com/yourusername/foodie-express',
    ),
    ProjectItem(
      title: 'SkyCast \u2013 Weather App',
      category: 'Web App',
      description:
          'A responsive Flutter Web app showing live weather with animated icons and forecasts.',
      techStack: ['Flutter Web', 'REST API', 'Provider'],
      icon: Icons.wb_sunny,
      gradient: [Color(0xFF13B9FD), Color(0xFF4F8CFF)],
      githubUrl: 'https://github.com/yourusername/skycast',
      liveUrl: 'https://yourusername.github.io/skycast',
    ),
    ProjectItem(
      title: 'Portfolio UI Kit',
      category: 'UI/UX',
      description:
          'A reusable set of animated Flutter UI components and design tokens for personal projects.',
      techStack: ['Flutter', 'Figma', 'Design System'],
      icon: Icons.palette,
      gradient: [Color(0xFF8B5CF6), Color(0xFFFF5C8A)],
      githubUrl: 'https://github.com/yourusername/flutter-ui-kit',
    ),
  ];

  // ---- Experience & Education ----
  static const List<ExperienceItem> experience = [
    ExperienceItem(
      role: 'Flutter Developer',
      company: 'Tech Solutions Pvt Ltd',
      duration: '2024 \u2013 Present',
      description:
          'Leading the development of cross-platform apps, mentoring junior developers and improving CI/CD pipelines.',
    ),
    ExperienceItem(
      role: 'Junior Flutter Developer',
      company: 'AppCraft Studio',
      duration: '2022 \u2013 2024',
      description:
          'Built and shipped 10+ production apps, integrated REST APIs and Firebase, and collaborated closely with UI/UX designers.',
    ),
    ExperienceItem(
      role: 'Flutter Intern',
      company: 'StartUp Hub',
      duration: '2021 \u2013 2022',
      description:
          "Learned the fundamentals of Flutter & Dart while contributing to internal tools and small client projects.",
    ),
    ExperienceItem(
      role: 'B.E. Computer Science',
      company: 'Anna University',
      duration: '2018 \u2013 2022',
      description: 'Graduated with a focus on mobile computing and software engineering.',
      isEducation: true,
    ),
  ];

  // ---- Achievements / Certifications ----
  static const List<String> achievements = [
    'Published 10+ apps with 50,000+ combined downloads',
    'Flutter & Dart certified developer',
    'Open source contributor to Flutter community packages',
    'Speaker at a local Flutter meetup on State Management',
  ];
}
