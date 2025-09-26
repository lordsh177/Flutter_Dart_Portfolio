import 'package:flutter/material.dart';

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
