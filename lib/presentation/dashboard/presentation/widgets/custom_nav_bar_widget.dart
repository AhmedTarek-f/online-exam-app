import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: _buildNavBarItem(
                  AppIcons.homeBarIcon, 'Explore', 0, context)),
          Expanded(
              child: _buildNavBarItem(
                  AppIcons.resultsBarIcon, 'Result', 1, context)),
          Expanded(
              child: _buildNavBarItem(
                  AppIcons.profileNavBarIcon, 'Profile', 2, context)),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(
      String icon, String label, int index, BuildContext context) {
    final bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70.w,
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30.r),
              color: isSelected
                  ? Colors.blueAccent.withOpacity(0.2)
                  : Colors.transparent,
            ),
            child: SvgPicture.asset(
              icon,
              height: 22.h,
              width: 22.w,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).primaryColor,
            ),
          ),
          RSizedBox(height: 20.h),
        ],
      ),
    );
  }
}
