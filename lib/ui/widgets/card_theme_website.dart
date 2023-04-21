import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';

class CardThemeWebsite extends StatefulWidget {
  final String thumbnail;

  const CardThemeWebsite({
    Key? key,
    required this.thumbnail,
  }) : super(key: key);

  @override
  State<CardThemeWebsite> createState() => _CardThemeWebsiteState();
}

class _CardThemeWebsiteState extends State<CardThemeWebsite> {
  double borderWidth = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 260,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(color: kPrimaryColor, width: borderWidth),
          image: DecorationImage(
            image: AssetImage(widget.thumbnail),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          borderWidth = borderWidth == 4.0 ? 0 : 4.0;
        });
      },
    );
  }
}
