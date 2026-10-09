import 'package:flutter/material.dart';

/// Central palette for the entire application.
/// All UI colors MUST be referenced from here — no inline hex values in widgets.
class AppColors {
  AppColors._();

  // ── Primary Brand Palette ─────────────────────────────────────────────────
  static const Color primaryColor    = Color(0xFF1B4B9F);
  static const Color deepBlue        = Color(0xFF16346B);
  static const Color accentBlue      = Color(0xFF2E63C4);

  // ── Vivid Accent (progress indicators, action links, dots) ────────────────
  static const Color accentBlueBright = Color(0xFF0066FF);

  // ── Header / AppBar ───────────────────────────────────────────────────────
  /// Solid blue used in the home CustomAppBar header
  static const Color headerBlue      = Color(0xFF0A4E8A);

  // ── Page Backgrounds ──────────────────────────────────────────────────────
  /// Soft white background (CheckEmailScreen scaffold)
  static const Color softWhiteBg    = Color(0xFFF8FAFC);
  /// Gradient start (light screens)
  static const Color lightBgTop     = Color(0xFFE9EFF9);
  /// Gradient end / solid scaffold (Register, ForgotPassword)
  static const Color lightBgBottom  = Color(0xFFF7F9FD);

  // ── Input / Field ─────────────────────────────────────────────────────────
  static const Color fieldBg        = Color(0xFFF3F5FA);
  static const Color fieldIconBg    = Color(0xFFDCE6F7);
  /// Light blue chip background (CheckEmail action tiles)
  static const Color lightBlueTint  = Color(0xFFE8F2FF);

  // ── Image Placeholder ─────────────────────────────────────────────────────
  /// Neutral off-white used as background for doctor image containers
  static const Color imagePlaceholderBg = Color(0xFFF4F6F9);

  // ── Dividers & Borders ────────────────────────────────────────────────────
  /// OR-section divider line
  static const Color dividerLine         = Color(0xFFDDE3EE);
  /// Border of Google/Facebook outlined buttons
  static const Color socialButtonBorder  = Color(0xFFE7EBF3);

  // ── Social Brand Colors ───────────────────────────────────────────────────
  static const Color googleBlue     = Color(0xFF4285F4);
  static const Color facebookBlue   = Color(0xFF1877F2);

  // ── Success & Error States ────────────────────────────────────────────────
  static const Color successGreenBg   = Color(0xFFE3F3E9);
  static const Color successGreen     = Color(0xFF2E9B58);
  static const Color errorRed         = Color(0xFFD32F2F);
  /// Light green chip background for "completed" status badges
  static const Color successGreenChip = Color(0xFFC8E6C9);

  // ── Appointment Status ────────────────────────────────────────────────────
  /// Light cyan background for "upcoming/pending" status badges
  static const Color lightCyanBg = Color(0xFFD9F3F8);
  /// Teal text color used for "upcoming/pending" status text
  static const Color tealText    = Color(0xFF0A8FBE);

  // ── Stars & Ratings ───────────────────────────────────────────────────────
  /// Amber used for star rating icons
  static const Color starAmber = Color(0xFFFFC107);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color textDark   = Color(0xFF1B1F2A);
  static const Color textGrey   = Color(0xFF6B7280);
  static const Color hintGrey   = Color(0xFF9AA3B2);
  /// Deep navy used for screen headings (e.g. CheckEmail title)
  static const Color textNavy   = Color(0xFF0F2B5B);
  /// Near-black — equivalent to Colors.black87 (0xDD000000)
  static const Color nearBlack  = Color(0xDD000000);

  // ── Grey Scale (shared across multiple widgets) ───────────────────────────
  static const Color greyShade200 = Color(0xFFEEEEEE);
  static const Color greyShade300 = Color(0xFFE0E0E0);
  static const Color greyShade400 = Color(0xFFBDBDBD);
  static const Color greyShade600 = Color(0xFF757575);
  static const Color greyShade700 = Color(0xFF616161);

  // ── Review Card ───────────────────────────────────────────────────────────
  /// Mint-tinted background for patient review cards
  static const Color reviewCardBg = Color(0xFFE0F2F1);

  // ── Surface / Overlay ─────────────────────────────────────────────────────
  /// Pure white — use instead of Colors.white
  static const Color white            = Color(0xFFFFFFFF);
  /// White at 60% opacity — used for action tile card backgrounds
  static const Color whiteSemiTransparent = Color(0x99FFFFFF);
  /// Light blue — equivalent to Colors.blue.shade100 (dot-line divider)
  static const Color blueTint100      = Color(0xFFBBDEFB);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [accentBlue, deepBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [accentBlue, deepBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bgGradient = LinearGradient(
    colors: [lightBgTop, lightBgBottom],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
