import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 24.0;
double defaultRadius = 10;



Color kPrimaryColor = Color(0xff673AB7);
Color kBlackColor = Color(0xff20113B);
Color kWhiteColor = Color(0xffffffff);
Color kGreyColor = Color(0xff9186A4);
Color kOutlineColor = Color(0xffCCC3DB);
Color kGreyOverlay = Color(0xffEBEBEB);
Color kDangerColor = Color.fromARGB(255, 255, 0, 0);



TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);

TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);

TextStyle outlineTextStyle = GoogleFonts.poppins(
  color: kOutlineColor,
);

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

TextStyle dangerTextStyle = GoogleFonts.poppins(
  color: kDangerColor,
);

FontWeight light = FontWeight.w300;
FontWeight reguler = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

Future<void> showMyDialog(context, Text title, List<Widget> contents, List<Widget> buttons) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: SingleChildScrollView(
          child: ListBody(
            children: contents,
          ),
        ),
        actions: buttons,
      );
    },
  );
}
