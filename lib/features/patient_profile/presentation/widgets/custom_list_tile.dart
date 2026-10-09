import 'package:flutter/material.dart';

class CustomeListTile extends StatelessWidget {
  const CustomeListTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    this.showArrow = false,
  });

  final Widget icon;
  final String title;
  final String? trailingText;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText!,
              style: const TextStyle(
                color: Color(0xFF007398),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          if (showArrow) ...[
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ],
      ),
      onTap: () {},
    );
  }
}
