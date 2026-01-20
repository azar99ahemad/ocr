import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.description_outlined,
            size: 64,
            color: Color(0xFFB9C28F),
          ),
          SizedBox(height: 16),
          Text(
            'No scans yet',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text(
            'Tap the camera button below to scan your first\nhandwritten note',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
