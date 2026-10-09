import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({super.key, this.asset});
  final String? asset;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: const BoxDecoration(color: AppColors.primaryColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'my_profile'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'manage_account_preferences'.tr(),
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 52,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage(asset ?? ""),
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 0,
                    end: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Color(0xFF007398),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
