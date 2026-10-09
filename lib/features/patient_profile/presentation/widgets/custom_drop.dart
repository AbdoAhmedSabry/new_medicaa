import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final String? selectedValue;
  final void Function(String?) onChanged;
  final IconData? prefixIcon;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedValue,
      isExpanded: true,
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,

      hint: Text(
        hintText,
        style: TextStyle(
          color: const Color(0xff9CA3AF),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),

      style: TextStyle(
        color: const Color(0xff1F2937),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),

      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Color(0xFF0A4E8A),
        size: 26,
      ),

      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF7FBFD),
        prefixIcon: Icon(prefixIcon, color: Color(0xFF0A4E8A), size: 22),

        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xffE5EDF3), width: 1.2),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Color(0xFF0A4E8A), width: 1.6),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),

      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xff1F2937),
            ),
          ),
        );
      }).toList(),

      onChanged: onChanged,
    );
  }
}
