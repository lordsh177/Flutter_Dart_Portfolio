import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/section.dart';
import '../widgets/footer.dart';

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

//
// 👇 Profile Section
//
class ProfileSection extends StatelessWidget {
  final ThemeMode themeMode;
  const ProfileSection({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: isDark
              ? const LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: !isDark ? Colors.white : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            const SizedBox(height: 16),
            Text(
              'Clark Lomopog',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Chip(
              label: const Text(
                'Bachelor of Science in Information Technology • 3rd Year',
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.blue.shade100,
            ),
            const SizedBox(height: 16),
            Text(
              'Passionate Flutter beginner crafting beautiful mobile experiences '
              'with clean code and innovative solutions',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              children: const [
                _ContactItem(Icons.email, 'lomopog.clark777@gmail.com'),
                _ContactItem(Icons.phone, '+63 965-610-6443'),
                _ContactItem(Icons.location_on, 'Villanueva, Mis. Or.'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactItem(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}

//
// 👇 Project Grid
//
class ProjectGrid extends StatelessWidget {
  final ThemeMode themeMode;
  const ProjectGrid({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth;
        if (constraints.maxWidth < 600) {
          cardWidth = constraints.maxWidth;
        } else if (constraints.maxWidth < 1000) {
          cardWidth = (constraints.maxWidth - 16) / 2;
        } else {
          cardWidth = (constraints.maxWidth - 32) / 3;
        }

        final projects = [
          (
            'assets/project1.PNG',
            'Completed',
            '3 months',
            'DIY Webpage',
            'A webpage midterm laboratory exam in my 2nd year.',
            ['HTML', 'CSS', 'Responsive'],
          ),
          (
            'assets/project2.PNG',
            'In Progress',
            '1 month',
            'E-Portfolio',
            'Final exam (2nd Year) creating an e-portfolio to help other users.',
            ['HTML', 'CSS', 'NODEJS', 'REACT'],
          ),
          (
            'assets/project3.PNG',
            'Completed',
            '6 months',
            '(IMS) Inventory Management System',
            'creating a system that applies CRUD operations.',
            ['SQLite', 'Java', 'Javascript', 'Python'],
          ),
        ];

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: projects
              .map(
                (p) => ProjectCard(
                  width: cardWidth,
                  imagePath: p.$1,
                  status: p.$2,
                  timeAgo: p.$3,
                  title: p.$4,
                  description: p.$5,
                  tags: p.$6,
                  themeMode: themeMode,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class ProjectCard extends StatelessWidget {
  final double width;
  final String imagePath, status, timeAgo, title, description;
  final List<String> tags;
  final ThemeMode themeMode;

  const ProjectCard({
    super.key,
    required this.width,
    required this.imagePath,
    required this.status,
    required this.timeAgo,
    required this.title,
    required this.description,
    required this.tags,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                imagePath,
                height: 140,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(
                          status,
                          style: TextStyle(
                            color: status == 'Completed'
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                        backgroundColor: status == 'Completed'
                            ? Colors.green.shade100
                            : Colors.orange.shade100,
                      ),
                      Text(
                        timeAgo,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    children: tags
                        .map(
                          (t) => Chip(
                            label: Text(
                              t,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                            backgroundColor: Colors.blue.shade50,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "View on GitHub",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// 👇 Skill Grid
//
class SkillGrid extends StatelessWidget {
  final ThemeMode themeMode;
  const SkillGrid({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final skills = [
      (Icons.phone_android, "Flutter & Dart", "Mobile Development", 0.30),
      (Icons.cloud, "JavaScript", "Backend Services", 0.55),
      (Icons.link, "CSS", "Design", 0.88),
      (Icons.code, "Git & GitHub", "Version Control", 0.92),
      (Icons.design_services, "HTML", "Integration", 0.80),
      (Icons.storage, "SQLite", "Database", 0.75),
      (Icons.cloud_queue, "Node.js", "Backend", 0.70),
      (Icons.bug_report, "Python", "Programming", 0.78),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: skills
          .map(
            (s) => SkillCard(
              icon: s.$1,
              skill: s.$2,
              role: s.$3,
              level: s.$4,
              themeMode: themeMode,
            ),
          )
          .toList(),
    );
  }
}

class SkillCard extends StatelessWidget {
  final IconData icon;
  final String skill, role;
  final double level;
  final ThemeMode themeMode;

  const SkillCard({
    super.key,
    required this.icon,
    required this.skill,
    required this.role,
    required this.level,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;
    final theme = Theme.of(context);

    return SizedBox(
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.blue, size: 28),
              const SizedBox(height: 8),
              Text(
                skill,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                role,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: level,
                backgroundColor: Colors.grey.shade300,
                color: Colors.blue,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 4),
              Text(
                "${(level * 100).toInt()}%",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
