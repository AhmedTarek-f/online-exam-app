import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timer_count_down/timer_controller.dart';
import '../../presentation/question/view_model/question_cubit.dart';
import '../constants/app_images.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// durationInSeconds in seconds to detect the time out duration ///
  final String title;
  final TextStyle? titleStyle;
  final bool isBackButtonExist;

  /// showTimer to show or hide timer widget ///
  final bool showTimer;
  final Color? titleColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.isBackButtonExist = true,
    this.showTimer = false,
    this.titleColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _formatTime(double timeInSeconds) {
    final duration = Duration(seconds: timeInSeconds.ceil());
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (widget.isBackButtonExist)
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_sharp,
                        color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                Text(widget.title,
                    style: widget.titleStyle ??
                        Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: widget.titleColor ?? Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                        )),
              ],
            ),

            /// Timer section ///
            if (widget.showTimer)
              BlocSelector<QuestionCubit, QuestionState, int>(
                selector: (state) =>
                state is QuestionLoaded ? state.remainingSeconds : 0,
                builder: (context, remainingSeconds) {
                  final timeText = _formatTime(remainingSeconds.toDouble());

                  return Row(
                    children: [
                      Image.asset(AppImages.alarmImage,
                          height: 28.h, width: 28.w),
                      const SizedBox(width: 4),
                      Text(
                        timeText,
                        style: TextStyle(
                          color: remainingSeconds <= 10
                              ? Colors.red
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
