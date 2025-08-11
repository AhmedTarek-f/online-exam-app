import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_exam_app/core/constants/app_icons.dart';
import 'package:online_exam_app/core/constants/app_images.dart';

class EditProfileImage extends StatelessWidget {
  const EditProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 40.5.r,
          backgroundColor: Colors.transparent,
          backgroundImage: const AssetImage(AppImages.defaultProfile),
        ),
        PositionedDirectional(
          bottom: 2.r,
          end: 2.r,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 24.r,
              height: 24.r,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: SvgPicture.asset(
                AppIcons.camera,
                width: 12.r,
                height: 12.r,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
