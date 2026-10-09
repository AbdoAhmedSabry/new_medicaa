import 'package:flutter/material.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'medicare_logo.dart';

class WaveClipper extends CustomClipper<Path> {
  final double waveHeight;
  WaveClipper(this.waveHeight);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - waveHeight);

    path.cubicTo(
      size.width * 0.25,
      size.height,
      size.width * 0.55,
      size.height - waveHeight * 1.6,
      size.width * 0.78,
      size.height - waveHeight * 0.55,
    );

    path.cubicTo(
      size.width * 0.92,
      size.height - waveHeight * 0.15,
      size.width * 0.97,
      size.height - waveHeight * 0.35,
      size.width,
      size.height - waveHeight * 0.85,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// The blue gradient wave header used on both the Create Account
/// and Forgot Password screens.
///
/// Spacing follows the design specs:
/// - Top Header Height: 320px
/// - Top Wave Curve Height: 80px
class WaveHeader extends StatelessWidget {
  final VoidCallback onBack;
  final Widget child;

  const WaveHeader({super.key, required this.onBack, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(80),
      child: Container(
        width: double.infinity,
        height: 320,
        decoration: const BoxDecoration(gradient: AppColors.headerGradient),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 80),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _BackButton(onTap: onBack),
                ),
                Center(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}

/// Heart-with-plus logo + "MediCare" title + tagline, used inside [WaveHeader].
// class MediCareBrand extends StatelessWidget {
//   final double iconSize;

//   const MediCareBrand({super.key, this.iconSize = 40.0});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(Icons.favorite, color: Colors.white, size: iconSize),
//         const SizedBox(height: 8),
//         Text('MediCare', style: AppTextStyles.font18LexendSemiBold),
//         const SizedBox(height: 2),
//         Text(
//           'Your Health, Our Priority',
//           style: AppTextStyles.font16InterRegular,
//         ),
//       ],
//     );
//   }
// }
class MediCareBrand extends StatelessWidget {
  final double iconSize;

  const MediCareBrand({super.key, this.iconSize = 200.0}); // كان 40

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // ياخد العرض كله فيتوسّط
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logoo1.png',
            height: iconSize, // دلوقتي iconSize = ارتفاع اللوجو الفعلي
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.favorite,
              color: AppColors.primaryColor,
              size: iconSize,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'MediCare',
            textAlign: TextAlign.center,
            style: AppTextStyles.font18LexendSemiBold,
          ),
          const SizedBox(height: 2),
          Text(
            'Your Health, Our Priority',
            textAlign: TextAlign.center,
            style: AppTextStyles.font16InterRegular,
          ),
        ],
      ),
    );
  }
}
