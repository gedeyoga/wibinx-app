import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';

class CustomSmallButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const CustomSmallButton({
    Key? key,
    required this.title,
    required this.onPressed,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      width: 82,
      height: 36,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: kOutlineColor),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: blackTextStyle.copyWith(
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
