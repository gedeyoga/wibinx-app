import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';

class CustomFormField extends StatelessWidget {
  final String title, hintText;
  final bool obsecureText;
  final int maxLines;
  final TextEditingController?  controller;
  final String? Function(String?) validator;
  final Function(String)? onChanged;
  final value;
  final String keyboardType;

  const CustomFormField({
    Key? key,
    required this.title,
    required this.hintText,
    this.obsecureText = false,
    this.maxLines = 1,
    this.controller,
    required this.validator ,
    this.value = null,
    this.onChanged,
    this.keyboardType = 'text',
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
            autovalidateMode: AutovalidateMode.always,
            controller: controller,
            cursorColor: kBlackColor,
            maxLines: maxLines,
            obscureText: obsecureText,
            keyboardType: keyboardType == 'number' ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
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
            validator: validator,
            initialValue: value,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
