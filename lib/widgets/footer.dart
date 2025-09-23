import 'package:flutter/material.dart';
import 'hover_icon_button.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

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
                onPressed: () {
                  // TODO: add GitHub link
                },
              ),
              HoverIconButton(
                icon: Icons.business,
                label: "LinkedIn",
                iconColor: Colors.blue,
                onPressed: () {
                  // TODO: add LinkedIn link
                },
              ),
              HoverIconButton(
                icon: Icons.email,
                label: "Email",
                iconColor: Colors.red,
                onPressed: () {
                  // TODO: add Email launcher
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '© 2025 My Portfolio. All rights reserved.',
            style: TextStyle(
              color: Colors.black, // ✅ always black
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
