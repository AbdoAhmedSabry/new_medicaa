import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_medicaa/features/patient_profile/presentation/manager/patient_cubit.dart';
import 'package:new_medicaa/features/patient_profile/presentation/manager/patient_state.dart';
import 'package:new_medicaa/features/patient_profile/presentation/widgets/app_bar_profile.dart';
import 'package:new_medicaa/features/patient_profile/presentation/widgets/custom_divider.dart';
import 'package:new_medicaa/features/patient_profile/presentation/widgets/custom_header.dart';
import 'package:new_medicaa/features/patient_profile/presentation/widgets/custom_list_tile.dart';

class ProfilePatientscreen extends StatelessWidget {
  const ProfilePatientscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: BlocConsumer<PatientCubit, PatientState>(
        listener: (context, state) {
          if (state is PatientLoggedOutSuccess ||
              state is PatientAccountDeletedSuccess) {
          } else if (state is PatientError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: const TextStyle(color: AppColors.white),
                ),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PatientLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
          }

          if (state is PatientSuccess) {
            final patientModel = state.patientModel;

            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomeAppBar(asset: patientModel.photoURL),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _buildSectionCard(
                          child: Column(
                            children: [
                              CustomeHedar(
                                title: 'personal_information'.tr(),
                                iconData: Icons.person_outline,
                              ),
                              const SizedBox(height: 5),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.person_outline,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'full_name_label'.tr(),
                                trailingText: patientModel.name,
                              ),
                              const CustomDivider(),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.email_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'email_address_label'.tr(),
                                trailingText: patientModel.email,
                              ),
                              const CustomDivider(),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.phone_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'phone_number_label'.tr(),
                                trailingText: patientModel.phone,
                              ),
                              const CustomDivider(),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.calendar_today_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'date_of_birth'.tr(),
                                trailingText: patientModel.age.toString(),
                              ),
                              const CustomDivider(),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'location'.tr(),
                                trailingText: 'cairo_egypt'.tr(),
                              ),
                              const CustomDivider(),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.water_drop_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'blood_type'.tr(),
                                trailingText: patientModel.bloodType,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildSectionCard(
                          child: Column(
                            children: [
                              CustomeHedar(
                                title: 'account_and_security'.tr(),
                                iconData: Icons.security,
                              ),
                              const SizedBox(height: 5),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.lock_outline,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'change_password'.tr(),
                                showArrow: true,
                              ),
                              const CustomDivider(),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.shield_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'privacy_settings'.tr(),
                                showArrow: true,
                              ),
                              const CustomDivider(),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.notifications_none_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'notification_preferences'.tr(),
                                showArrow: true,
                              ),
                              const CustomDivider(),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.phonelink_lock_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'two_factor_authentication'.tr(),
                                showArrow: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildSectionCard(
                          child: Column(
                            children: [
                              CustomeHedar(
                                title: 'health_information'.tr(),
                                iconData: Icons.favorite_border,
                              ),
                              const SizedBox(height: 5),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.coronavirus_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'allergies'.tr(),
                                trailingText: 'allergies_value'.tr(),
                                showArrow: true,
                              ),
                              const CustomDivider(),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.medical_information_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'medical_conditions'.tr(),
                                trailingText: 'no_conditions'.tr(),
                                showArrow: true,
                              ),
                              const CustomDivider(),
                              CustomeListTile(
                                icon: const Icon(
                                  Icons.medication_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'current_medications'.tr(),
                                trailingText: 'vitamin_d'.tr(),
                                showArrow: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              context.read<PatientCubit>().logOut();
                            },
                            icon: const Icon(Icons.logout, color: Colors.white),
                            label: Text(
                              'logout'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              context.read<PatientCubit>().deletAccount(
                                id: patientModel.uid,
                              );
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            label: Text(
                              'delete_account'.tr(),
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
