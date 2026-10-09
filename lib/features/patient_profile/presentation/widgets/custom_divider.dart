import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color(0xFFEEEEEE),
      thickness: 1,
      indent: 16,
      endIndent: 16,
      height: 1,
    );
  }
}
