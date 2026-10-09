import 'package:flutter/material.dart';

class CustomeHedar extends StatelessWidget {
  const CustomeHedar({super.key, required this.title, required this.iconData});

  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF007398),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(iconData, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
