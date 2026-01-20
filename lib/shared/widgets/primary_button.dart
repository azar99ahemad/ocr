import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool filled;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = filled ? const Color(0xFFBFC89A) : Colors.transparent;
    final borderColor =
        filled ? const Color(0xFF9AA36F) : const Color(0xFF9AA36F);

    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: Colors.black),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
