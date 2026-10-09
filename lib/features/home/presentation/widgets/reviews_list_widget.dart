import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/features/home/presentation/widgets/review_card_widget.dart';

class ReviewsListWidget extends StatelessWidget {
  const ReviewsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        const ReviewCardWidget(
          name: 'Ahmed Mohamed',
          time: '2 days ago',
          comment: 'Excellent doctor! Very professional and friendly.',
          stars: 5,
        ),
        SizedBox(height: 12.h),
        const ReviewCardWidget(
          name: 'Sara Ali',
          time: '1 week ago',
          comment: 'Highly recommended. She explains everything clearly.',
          stars: 5,
        ),
      ],
    );
  }
}
