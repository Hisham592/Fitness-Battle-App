import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarTitleWidget extends StatelessWidget {
  final String title;
  const AppBarTitleWidget({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.08,
      ),
    );
  }
}