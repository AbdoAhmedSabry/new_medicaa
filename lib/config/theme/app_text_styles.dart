import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';

/// All text styles for the application.
///
/// Rules:
///  • Every style MUST declare [fontFamily] explicitly — never rely on the
///    theme default, so styles look the same whether used inside or outside
///    a themed [MaterialApp].
///  • Sizes use [sp] so they scale with device text-scale factor AND
///    ScreenUtil's design size.
///  • Colors are NOT set here by default (stays [null] → inherits).
///    Apply color via `.copyWith(color: AppColors.xxx)` at the call-site.
///    Exception: styles that are semantically bound to a single color
///    (e.g. the Lexend logo style with [AppColors.primaryColor]).
class AppTextStyles {
  AppTextStyles._();

  // ── Font family constants ─────────────────────────────────────────────────
  static const String _cairo      = 'Cairo';
  static const String _lexend     = 'Lexend';
  static const String _inter      = 'Inter';
  static const String _averia     = 'Averia Sans Libre';

  // =========================================================================
  // Lexend — Logo / Brand
  // =========================================================================
  static TextStyle font70LexendSemiBold = TextStyle(
    fontSize: 70.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _lexend,
    color: AppColors.primaryColor,
  );

  // =========================================================================
  // Lexend — Screen Headings / Titles (H1 … H3)
  // Use these for all heading Text widgets on auth screens.
  // =========================================================================

  /// Auth screen primary title — e.g. "Welcome Back", "Create Account"
  static TextStyle font26LexendBold = TextStyle(
    fontSize: 26.sp,
    fontWeight: FontWeight.w700,
    fontFamily: _lexend,
  );

  static TextStyle font22LexendBold = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    fontFamily: _lexend,
  );

  static TextStyle font22LexendSemiBold = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _lexend,
  );

  static TextStyle font20LexendSemiBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _lexend,
  );

  static TextStyle font18LexendSemiBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _lexend,
  );

  // =========================================================================
  // Inter — Body Text / Subtitles / Labels / Hints
  // Use these for all non-heading Text widgets on auth screens.
  // =========================================================================

  static TextStyle font16InterSemiBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _inter,
  );

  static TextStyle font16InterRegular = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _inter,
  );

  static TextStyle font14InterSemiBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _inter,
  );

  static TextStyle font14InterRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _inter,
  );

  static TextStyle font13InterSemiBold = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _inter,
  );

  static TextStyle font13InterRegular = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _inter,
  );

  static TextStyle font12InterSemiBold = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _inter,
  );

  static TextStyle font12InterRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _inter,
  );

  static TextStyle font18InterSemiBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _inter,
  );


  // =========================================================================
  // Open Sans — Primary UI font
  // =========================================================================

  static TextStyle font40Bold = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.w700,
    fontFamily: _cairo,
  );

  static TextStyle font26Bold = TextStyle(
    fontSize: 26.sp,
    fontWeight: FontWeight.w700,
    fontFamily: _cairo,
  );

  static TextStyle font24SemiBold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _cairo,
  );

  static TextStyle font22Bold = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    fontFamily: _cairo,
  );

  static TextStyle font22SemiBold = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _cairo,
  );

  static TextStyle font20Bold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    fontFamily: _cairo,
  );

  static TextStyle font20SemiBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _cairo,
  );

  static TextStyle font20Regular = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _cairo,
  );

  static TextStyle font18SemiBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _cairo,
  );

  static TextStyle font18Regular = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _cairo,
  );

  static TextStyle font16SemiBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _cairo,
  );

  static TextStyle font16Regular = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _cairo,
  );

  static TextStyle font14SemiBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _cairo,
  );

  static TextStyle font14Regular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _cairo,
  );

  static TextStyle font13Regular = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _cairo,
  );

  static TextStyle font13SemiBold = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _cairo,
  );

  static TextStyle font12Regular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _cairo,
  );

  static TextStyle font12SemiBold = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _cairo,
  );

  // =========================================================================
  // Averia Sans Libre — Payment cards
  // =========================================================================

  static TextStyle font22BoldAveria = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    fontFamily: _averia,
  );

  static TextStyle font18AveriaRegular = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _averia,
  );

  static TextStyle font12AveriaRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _averia,
  );
}
