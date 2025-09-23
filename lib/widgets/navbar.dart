import 'package:flutter/material.dart';
import 'theme_toggle.dart';

class Navbar extends StatefulWidget {
  final VoidCallback onProfile;
  final VoidCallback onProjects;
  final VoidCallback onSkills;
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  final bool isMobile;

  const Navbar({
    super.key,
    required this.onProfile,
    required this.onProjects,
    required this.onSkills,
    required this.onToggleTheme,
    required this.themeMode,
    required this.isMobile,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  // ignore: unused_field
  bool _hoveringHamburger = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 20, 16, 83), // ✅ Dark navy blue
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ✅ Left: Brand / Title
          Row(
            children: const [
              Icon(Icons.account_circle, size: 36, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'My Portfolio',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // ✅ Right
          Row(
            children: [
              if (!widget.isMobile) ...[
                TextButton.icon(
                  onPressed: widget.onProfile,
                  icon: const Icon(Icons.person, color: Colors.white),
                  label: const Text(
                    'Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton.icon(
                  onPressed: widget.onProjects,
                  icon: const Icon(Icons.work, color: Colors.white),
                  label: const Text(
                    'Projects',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton.icon(
                  onPressed: widget.onSkills,
                  icon: const Icon(Icons.code, color: Colors.white),
                  label: const Text(
                    'Skills',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
              ],

              // Theme toggle
              ThemeToggle(
                onToggle: widget.onToggleTheme,
                themeMode: widget.themeMode,
              ),

              const SizedBox(width: 12),

              // ✅ Mobile hamburger
              if (widget.isMobile)
                MouseRegion(
                  onEnter: (_) => setState(() => _hoveringHamburger = true),
                  onExit: (_) => setState(() => _hoveringHamburger = false),
                  cursor: SystemMouseCursors.click,
                  child: PopupMenuButton<int>(
                    color: const Color.fromARGB(
                      255,
                      20,
                      16,
                      83,
                    ), // ✅ Dark navy background
                    tooltip: 'show menu',
                    onSelected: (value) {
                      if (value == 0) widget.onProfile();
                      if (value == 1) widget.onProjects();
                      if (value == 2) widget.onSkills();
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(Icons.person, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Profile',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.work, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Projects',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const PopupMenuItem<int>(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(Icons.code, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Skills',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                    child: const Icon(Icons.menu, color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
