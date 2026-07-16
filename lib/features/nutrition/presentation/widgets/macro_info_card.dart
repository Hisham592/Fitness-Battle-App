import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class MacroInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color backgroundColor;
  final Color highlightColor;
  final Color borderColor;
  const MacroInfoCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    this.highlightColor = Colors.white,
    this.backgroundColor = const Color(0xFF1C1C1C),
    this.borderColor = const Color(0xFF2E2E2E),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: highlightColor,
              ),

              children: [
                if (unit.isNotEmpty)
                  TextSpan(
                    text: ' $unit',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: highlightColor,
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF444444),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
