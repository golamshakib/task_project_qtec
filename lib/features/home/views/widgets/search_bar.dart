import 'package:flutter/material.dart';
import 'package:task_project/core/utils/constants/app_sizer.dart';

import '../../../../core/utils/constants/app_color.dart';
import '../../../../core/utils/constants/icon_path.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const CustomSearchBar({
    super.key,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.h),
          color: Colors.transparent,
          border: Border.all(width: 1,color: Color(0xffD1D5DB))
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search products',
          hintStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14.sp,
          ),
          prefixIcon:  Image.asset(IconPath.search,height: 16.h,),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
