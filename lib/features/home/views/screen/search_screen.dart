import 'package:flutter/material.dart';
import 'package:task_project/core/utils/constans/app_sizer.dart';

import '../../../../core/utils/constans/app_color.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
      
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            ),
          ],
        ),
      ),
    );
  }
}
