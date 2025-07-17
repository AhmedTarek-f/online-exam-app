import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallCircleText extends StatelessWidget {
  const SmallCircleText({
    super.key,
    required this.borderColor,
    required this.text,
    this.width,
    this.height,
    required this.textStyle,
  });
  final Color borderColor;
  final TextStyle textStyle;
  final String text;
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ?? 25.r,
      height: height ?? 25.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(text, style: textStyle),
      ),
    );
  }
}
