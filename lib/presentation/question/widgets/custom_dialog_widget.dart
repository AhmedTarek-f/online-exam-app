// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:online_exam_app/core/common_widgets/custom_elevated_button.dart';
//
// class CustomDialogWidget extends StatelessWidget {
//   const CustomDialogWidget({
//     super.key,
//     required this.buttonTitle,
//     required this.onPressed,
//     required this.icon,
//   });
//
//   final String buttonTitle;
//   final VoidCallback onPressed;
//   final String icon;
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (_, __) => false,
//       child: Dialog(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//         backgroundColor: Colors.white,
//         child: Padding(
//           padding: EdgeInsets.all(20.w),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset(
//                     icon,
//                     height: 130.h,
//                     width: 130.w,
//                   ),
//                   Text(
//                     "Time's out !!",
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                           fontSize: 24.sp,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.red,
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 24.h),
//               CustomElevatedButton(
//                 onPressed: onPressed,
//                 buttonTitle: buttonTitle,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/common_widgets/custom_elevated_button.dart';

class CustomDialogContent extends StatelessWidget {
  const CustomDialogContent({super.key, this.actions, this.content});

  final List<Widget>? actions;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: REdgeInsets.symmetric(vertical: 40, horizontal: 22),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: content,
      actions: actions,
    );
  }
}

abstract class Dialogs {
  static customDialog({
    required BuildContext context,
    List<Widget>? actions,
    Widget? content,
  }) {
    return showDialog(
      context: context,
      builder: (context) =>
          CustomDialogContent(content: content, actions: actions),
    );
  }

  static startQuiz({
    required BuildContext context,
    required void Function()? onStart,
  }) {
    return customDialog(
      context: context,
      content: Text(
        'startQuizMessage',
        style: Theme.of(context).textTheme.labelMedium,
        textAlign: TextAlign.center,
      ),
      actions: [
        CustomElevatedButton(onPressed: onStart, buttonTitle: "start"),
      ],
    );
  }
}
