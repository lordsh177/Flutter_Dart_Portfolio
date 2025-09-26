import 'package:flutter/material.dart';

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
