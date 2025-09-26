import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../sections/section.dart';
import '../widgets/footer.dart';
import '../sections/profile_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const HomePage({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _profileKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _skillsKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Navbar(
              onProfile: () => _scrollTo(_profileKey),
              onProjects: () => _scrollTo(_projectsKey),
              onSkills: () => _scrollTo(_skillsKey),
              onToggleTheme: widget.onToggleTheme,
              themeMode: widget.themeMode,
              isMobile: isMobile,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileSection(
                      key: _profileKey,
                      themeMode: widget.themeMode,
                    ),
                    Section(
                      key: _projectsKey,
                      title: 'Featured Projects',
                      icon: Icons.work,
                      child: ProjectGrid(themeMode: widget.themeMode),
                    ),
                    Section(
                      key: _skillsKey,
                      title: 'Skills & Expertise',
                      icon: Icons.code,
                      child: SkillGrid(themeMode: widget.themeMode),
                    ),
                    const SizedBox(height: 40),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Contact Me clicked!")));
        },
        label: const Text(
          "Contact Me",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.mail, color: Colors.white),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
