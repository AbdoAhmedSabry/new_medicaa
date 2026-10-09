import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class AuthStateAccount extends StatelessWidget {
  const AuthStateAccount({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.ontap,
  });
  final String firstText;
  final String secondText;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: AppTextStyles.font16SemiBold.copyWith(
            color: AppColors.hintGrey,
          ),
        ),
        TextButton(
          onPressed: ontap,
          child: Text(
            secondText,
            style: AppTextStyles.font16SemiBold.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
