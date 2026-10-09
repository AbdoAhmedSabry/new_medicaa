import 'package:flutter/material.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';

class MediCareMark extends StatelessWidget {
  final double size;
  final Color color;
  const MediCareMark({super.key, this.size = 70, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.favorite, size: size, color: color),
          Icon(Icons.favorite_border, size: size, color: color),
          Positioned(
            child: Container(
              padding: EdgeInsets.all(size * 0.11),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, size: size * 0.34, color: color),
            ),
          ),
        ],
      ),
    );
  }
}

// class MediCareBrand extends StatelessWidget {
//   final bool onBlue;
//   final double markSize;
//   const MediCareBrand({super.key, this.onBlue = false, this.markSize = 64});

//   @override
//   Widget build(BuildContext context) {
//     final markColor = onBlue ? Colors.white : AppColors.primaryColor;
//     return Column(
//       children: [
//         MediCareMark(size: markSize, color: markColor),
//         const SizedBox(height: 8),
//         Text(
//           'MediCare',
//           style: onBlue ? AppText.brandTitleOnBlue : AppText.brandTitle,
//         ),
//         const SizedBox(height: 2),
//         Text(
//           'Your Health, Our Priority',
//           style: onBlue ? AppText.brandTaglineOnBlue : AppText.brandTagline,
//         ),
//       ],
//     );
//   }
// }
