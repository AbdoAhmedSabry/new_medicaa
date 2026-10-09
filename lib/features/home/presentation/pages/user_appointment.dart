import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';
import 'package:new_medicaa/features/home/presentation/manager/appointment_cubit.dart';
import 'package:new_medicaa/features/home/presentation/manager/appointment_state.dart';

// class UserAppointmentPage extends StatefulWidget {
//   const UserAppointmentPage({super.key});

//   @override
//   State<UserAppointmentPage> createState() => _UserAppointmentPageState();
// }

// class _UserAppointmentPageState extends State<UserAppointmentPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<AppointmentCubit>().getMyAppointment();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Stack(
//           children: [
//             /// الصورة العلوية
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               height: 300.h,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/profilephoto.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),

//             /// الجزء الأبيض
//             Positioned(
//               top: 260.h,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(35.r),
//                     topRight: Radius.circular(35.r),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.nearBlack.withValues(alpha: 0.08),
//                       blurRadius: 30.r,
//                       spreadRadius: 2,
//                       offset: Offset(0, 5.h),
//                     ),
//                   ],
//                 ),

//                 child: BlocBuilder<AppointmentCubit, AppointmentState>(
//                   builder: (context, state) {
//                     if (state is AppointmentLoadingState) {
//                       return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
//                     } else if (state is AppointmentErrorState) {
//                       return Center(
//                         child: Text(
//                           state.message,
//                           style: AppTextStyles.font16Regular.copyWith(
//                             color: AppColors.successGreen,
//                           ),
//                         ),
//                       );
//                     } else if (state is AppointmentSuccessState) {
//                       final appointments = state.appointments;

//                       if (appointments.isEmpty) {
//                         return Center(
//                           child: Text(
//                             "لا توجد حجوزات حالياً",
//                             style: AppTextStyles.font18SemiBold.copyWith(
//                               color: AppColors.textGrey,
//                             ),
//                           ),
//                         );
//                       }

//                       return Center(
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                             maxWidth: Responsive(context).maxContentWidth,
//                           ),
//                           child: ListView.separated(
//                             padding: EdgeInsets.all(20.w),
//                             itemCount: appointments.length,
//                             separatorBuilder: (context, index) =>
//                                 SizedBox(height: 20.h),
//                             itemBuilder: (context, index) {
//                               final appointment = appointments[index];

//                               return _buildAppointmentCard(
//                                 doctorName:
//                                     appointment.doctorName ?? "Unknown Doctor",
//                                 speciality: appointment.speciality ?? "General",
//                                 date: appointment.date,
//                                 time: appointment.time,
//                                 location:
//                                     appointment.consultationType == 'online'
//                                     ? "Online Consultation"
//                                     : "Medical Clinic",
//                                 status: appointment.status,
//                                 imageUrl: appointment.doctorImage,
//                               );
//                             },
//                           ),
//                         ),
//                       );
//                     }

//                     return const SizedBox.shrink();
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAppointmentCard({
//     required String doctorName,
//     required String speciality,
//     required String date,
//     required String time,
//     required String location,
//     required String status,
//     String? imageUrl,
//   }) {
//     final bool isCompleted = status.toLowerCase() == "completed";

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(18.w),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(18.r),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.nearBlack.withValues(alpha: 0.08),
//             blurRadius: 18.r,
//             spreadRadius: 1,
//             offset: Offset(0, 4.h),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 28.r,
//                 backgroundColor: AppColors.greyShade200,
//                 backgroundImage: imageUrl != null && imageUrl.isNotEmpty
//                     ? NetworkImage(imageUrl)
//                     : const AssetImage("assets/images/doctor.png")
//                           as ImageProvider,
//               ),
//               SizedBox(width: 12.w),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(doctorName, style: AppTextStyles.font18SemiBold),
//                     Text(
//                       speciality,
//                       style: AppTextStyles.font13Regular.copyWith(
//                         color: AppColors.greyShade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
//                 decoration: BoxDecoration(
//                   color: isCompleted
//                       ? AppColors.successGreenChip
//                       : AppColors.lightCyanBg,
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 child: Text(
//                   status[0].toUpperCase() + status.substring(1),
//                   style: AppTextStyles.font12SemiBold.copyWith(
//                     color: isCompleted
//                         ? AppColors.successGreen
//                         : AppColors.tealText,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 18.h),

//           Row(
//             children: [
//               Icon(
//                 Icons.calendar_today_outlined,
//                 size: 18.r,
//                 color: AppColors.textGrey,
//               ),
//               SizedBox(width: 8.w),
//               Text(date, style: AppTextStyles.font13Regular),
//             ],
//           ),

//           SizedBox(height: 10.h),

//           Row(
//             children: [
//               Icon(Icons.access_time, size: 18.r, color: AppColors.textGrey),
//               SizedBox(width: 8.w),
//               Text(time, style: AppTextStyles.font13Regular),
//             ],
//           ),

//           SizedBox(height: 10.h),

//           Row(
//             children: [
//               Icon(
//                 Icons.location_on_outlined,
//                 size: 18.r,
//                 color: AppColors.textGrey,
//               ),
//               SizedBox(width: 8.w),
//               Expanded(
//                 child: Text(location, style: AppTextStyles.font13Regular),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAppointmentPage extends StatefulWidget {
  const UserAppointmentPage({super.key});

  @override
  State<UserAppointmentPage> createState() => _UserAppointmentPageState();
}

class _UserAppointmentPageState extends State<UserAppointmentPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AppointmentCubit>().getMyAppointment());
  }

  @override
  Widget build(BuildContext context) {
    // استخدمنا DefaultTabController عشان نقسم الشاشة لـ 3 أقسام
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.white, // أو لون خلفية التطبيق الفاتح
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'my_appointments'.tr(),
            style: AppTextStyles.font18SemiBold.copyWith(
              color: AppColors.textDark,
            ),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.primaryColor,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.greyShade600,
            labelStyle: AppTextStyles.font14SemiBold,
            tabs: [
              Tab(text: 'upcoming'.tr()),
              Tab(text: 'completed'.tr()),
              Tab(text: 'cancelled'.tr()),
            ],
          ),
        ),
        body: BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            if (state is AppointmentLoadingState) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
            } else if (state is AppointmentErrorState) {
              return Center(
                child: Text(state.message, style: TextStyle(color: Colors.red)),
              );
            } else if (state is AppointmentSuccessState) {
              final appointments = state.appointments;

              if (appointments.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 80.r,
                        color: AppColors.greyShade200,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'no_appointments_yet'.tr(),
                        style: AppTextStyles.font16SemiBold.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // فلترة المواعيد بناءً على حالتها (دي محتاجة تظبيط حسب الداتا بتاعتك)
              final upcoming = appointments
                  .where((a) => a.status == 'booked')
                  .toList();
              final completed = appointments
                  .where((a) => a.status == 'completed')
                  .toList();
              final cancelled = appointments
                  .where((a) => a.status == 'cancelled')
                  .toList();

              return TabBarView(
                children: [
                  _buildAppointmentsList(upcoming, isUpcoming: true),
                  _buildAppointmentsList(completed, isUpcoming: false),
                  _buildAppointmentsList(cancelled, isUpcoming: false),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildAppointmentsList(List appointments, {required bool isUpcoming}) {
    if (appointments.isEmpty) {
      return Center(
        child: Text(
          'no_appointments_in_section'.tr(),
          style: AppTextStyles.font14Regular.copyWith(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(20.w),
      itemCount: appointments.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return _buildModernAppointmentCard(
          doctorName: appointment.doctorName ?? "Unknown Doctor",
          speciality: appointment.speciality ?? "Specialist",
          date: appointment.date,
          time: appointment.time,
          consultationType: appointment.consultationType ?? 'clinic',
          imageUrl: appointment.doctorImage,
          isUpcoming: isUpcoming,
        );
      },
    );
  }

  Widget _buildModernAppointmentCard({
    required String doctorName,
    required String speciality,
    required String date,
    required String time,
    required String consultationType,
    required bool isUpcoming,
    String? imageUrl,
  }) {
    final isOnline = consultationType.toLowerCase() == 'online';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.greyShade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. Doctor Info Row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 60.w,
                  height: 60.w,
                  color: AppColors.imagePlaceholderBg,
                  child: imageUrl != null && imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.person, color: Colors.grey),
                        )
                      : Image.asset(
                          'assets/images/doctor.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctorName, style: AppTextStyles.font16SemiBold),
                    SizedBox(height: 4.h),
                    Text(
                      speciality,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.greyShade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isOnline
                      ? AppColors.lightCyanBg
                      : AppColors.greyShade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      isOnline ? Icons.video_camera_front : Icons.storefront,
                      size: 14.r,
                      color: isOnline
                          ? AppColors.primaryColor
                          : AppColors.textGrey,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      isOnline ? 'online'.tr() : 'clinic'.tr(),
                      style: AppTextStyles.font12SemiBold.copyWith(
                        color: isOnline
                            ? AppColors.primaryColor
                            : AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          const Divider(height: 1, thickness: 1),
          SizedBox(height: 16.h),

          // 2. Date & Time Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 18.r,
                    color: AppColors.textGrey,
                  ),
                  SizedBox(width: 6.w),
                  Text(date, style: AppTextStyles.font13SemiBold),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_filled,
                    size: 18.r,
                    color: AppColors.textGrey,
                  ),
                  SizedBox(width: 6.w),
                  Text(time, style: AppTextStyles.font13SemiBold),
                ],
              ),
            ],
          ),

          // 3. Action Buttons (Only for Upcoming)
          if (isUpcoming) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Cancel Logic
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text('cancel'.tr()),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      isOnline ? 'join_call'.tr() : 'get_directions'.tr(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
