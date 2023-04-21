import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';

class CustomFormFieldGroup extends StatelessWidget {
  final String title, hintText, icon;
  final bool obsecureText;
  final int maxLines;

  const CustomFormFieldGroup({
    Key? key,
    required this.title,
    required this.hintText,
    required this.icon,
    this.obsecureText = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackTextStyle,
          ),
          SizedBox(
            height: 6,
          ),
          TextFormField(
            cursorColor: kBlackColor,
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixIcon: Container(
                width: 29,
                height: 29,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(icon),
                    scale: 1.3,
                  ),
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
