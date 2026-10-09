import 'package:flutter/material.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';


class AppTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.fieldBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7EBF3)),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword && _obscured,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        style: AppText.fieldText,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
          hintText: widget.hint,
          hintStyle: AppText.fieldHint,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.fieldIconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(widget.icon, size: 16, color: AppColors.primaryColor),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 46,
            minHeight: 46,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  splashRadius: 20,
                  icon: Icon(
                    _obscured
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.hintGrey,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _obscured = !_obscured),
                )
              : null,
        ),
      ),
    );
  }
}
