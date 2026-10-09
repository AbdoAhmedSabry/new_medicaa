import 'package:flutter/material.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class AppTextTheme {
  // Dark Theme Text Theme
  static TextTheme get dark => TextTheme(
    displayLarge: AppTextStyles.font40Bold,
    displayMedium: AppTextStyles.font26Bold,
    displaySmall: AppTextStyles.font24SemiBold,
    headlineMedium: AppTextStyles.font22Bold,
    headlineSmall: AppTextStyles.font20Bold,
    titleLarge: AppTextStyles.font18SemiBold,
    titleMedium: AppTextStyles.font16SemiBold,
    titleSmall: AppTextStyles.font14Regular,
    bodyLarge: AppTextStyles.font18Regular,
    bodyMedium: AppTextStyles.font16Regular,
    bodySmall: AppTextStyles.font14Regular,
    labelLarge: AppTextStyles.font12Regular,
  );

  // Light Theme Text Theme
  static TextTheme get light => TextTheme(
    displayLarge: AppTextStyles.font40Bold,
    displayMedium: AppTextStyles.font26Bold,
    displaySmall: AppTextStyles.font24SemiBold,
    headlineMedium: AppTextStyles.font22Bold,
    headlineSmall: AppTextStyles.font20Bold,
    titleLarge: AppTextStyles.font18SemiBold,
    titleMedium: AppTextStyles.font16SemiBold,
    titleSmall: AppTextStyles.font14Regular,
    bodyLarge: AppTextStyles.font18Regular,
    bodyMedium: AppTextStyles.font16Regular,
    bodySmall: AppTextStyles.font14Regular,
    labelLarge: AppTextStyles.font12Regular,
  );
}
