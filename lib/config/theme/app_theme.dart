import 'package:flutter/material.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_theme.dart';

// class AppTheme {
//   static ThemeData get darkTheme => ThemeData(
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: AppColors.backgroundColor,
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: AppColors.backgroundColor,
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//     ),
//   );

//   // Light Theme Configuration
//   static ThemeData get lightTheme => ThemeData(
//     brightness: Brightness.light,
//     primaryColor: AppColors.primaryColor,
//     scaffoldBackgroundColor: Colors.white,
//     textTheme: AppTextTheme.light,

//     cardTheme: const CardThemeData(
//       color: Color(0xFFD2EBE7),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(8)),
//       ),
//     ),

//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Colors.grey[100],
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide.none,
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide.none,
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
//       ),
//     ),
//   );
// }

class AppText {
  AppText._();

  static const String fontFamily = 'Cairo';

  static TextStyle brandTitle = const TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryColor,
    letterSpacing: 0.2,
  );

  static TextStyle brandTitleOnBlue = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static TextStyle brandTagline = const TextStyle(
    fontSize: 13,
    color: AppColors.textGrey,
    fontWeight: FontWeight.w500,
  );

  static TextStyle brandTaglineOnBlue = TextStyle(
    fontSize: 13,
    color: Colors.white.withOpacity(0.85),
    fontWeight: FontWeight.w500,
  );

  static TextStyle heading = const TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textDark,
  );

  static TextStyle subheading = const TextStyle(
    fontSize: 14.5,
    color: AppColors.textGrey,
    fontWeight: FontWeight.w400,
  );

  static TextStyle fieldText = const TextStyle(
    fontSize: 15,
    color: AppColors.textDark,
    fontWeight: FontWeight.w500,
  );

  static TextStyle fieldHint = const TextStyle(
    fontSize: 15,
    color: AppColors.hintGrey,
    fontWeight: FontWeight.w400,
  );

  static TextStyle link = const TextStyle(
    fontSize: 13.5,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w700,
  );

  static TextStyle buttonLabel = const TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );

  static TextStyle bodyGrey = const TextStyle(
    fontSize: 13.5,
    color: AppColors.textGrey,
  );
}

/// Simple responsive helper: clamps horizontal padding & max content
/// width so the design scales gracefully from small phones to tablets/web.
class Responsive {
  final BuildContext context;
  Responsive(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  bool get isTablet => width >= 600;
  bool get isSmallPhone => width < 360;

  double get maxContentWidth => isTablet ? 480 : width;

  double get horizontalPadding => isTablet ? 32 : (isSmallPhone ? 20 : 24);

  double scaleFont(double base) {
    if (isSmallPhone) return base * 0.92;
    if (isTablet) return base * 1.05;
    return base;
  }
}
