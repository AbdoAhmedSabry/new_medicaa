import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    super.key,
    required this.label,
    required this.hintText,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.onChanged,
    this.validator,
    this.prefix,
    this.obscureText = false,
  });
  final String label;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function(String)? onChanged;
  String? Function(String?)? validator;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      obscureText: obscureText,

      decoration: InputDecoration(
       
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: const BorderSide(color: Color(0xffE8EEF3), width: 1.3),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: const BorderSide(color: Color(0xff0A8FBE), width: 1.7),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: const BorderSide(color: Color(0xffEF4444)),
        ),

        hintText: hintText,
        hintStyle: AppTextStyles.font18Regular,
        suffixIcon: suffixIcon,
        prefixIcon: prefix,
      ),
    );
  }
}
