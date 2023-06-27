import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';

class CustomButtonDeleteSecondary extends StatelessWidget {
  final String title;
  final double width;
  final Function() onPressed;
  final EdgeInsets margin;

  const CustomButtonDeleteSecondary({
    Key? key,
    required this.title,
    this.width = double.infinity,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: 55,
      child: TextButton(
        style: TextButton.styleFrom(
          // backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
            side: BorderSide(color: kDangerColor),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: dangerTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
