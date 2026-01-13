import 'package:flutter/material.dart';

class IconPillButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const IconPillButton({super.key, 
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
