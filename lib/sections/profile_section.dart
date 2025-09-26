import 'package:flutter/material.dart';

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
