import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hover_icon_button.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  // Helper function to open URLs
  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            children: [
              HoverIconButton(
                icon: Icons.code,
                label: "GitHub",
                iconColor: Colors.black,
                onPressed: () => _openUrl(
                  "https://github.com/lordsh177/Flutter_Dart_Portfolio/tree/main",
                ),
              ),
              HoverIconButton(
                icon: Icons.business,
                label: "LinkedIn",
                iconColor: Colors.blue,
                onPressed: () =>
                    _openUrl("https://www.linkedin.com/in/your-profile"),
              ),
              HoverIconButton(
                icon: Icons.email,
                label: "Email",
                iconColor: Colors.red,
                onPressed: () => _openUrl("mailto:lomopog.clark777@gmail.com"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '© 2025 My Portfolio. All rights reserved.',
            style: TextStyle(color: Colors.black, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
