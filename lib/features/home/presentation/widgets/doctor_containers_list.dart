import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/home/presentation/widgets/doctor_container.dart';

class DoctorcontainersList extends StatelessWidget {
  const DoctorcontainersList({super.key, required this.doctors});
  final List<DoctorEntity> doctors;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return Padding(
          padding: EdgeInsets.all(8.w),
          child: Doctorcontainer(doctor: doctor),
        );
      },
    );
  }
}
