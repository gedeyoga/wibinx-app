import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';

class NavbarTop extends StatelessWidget {

  final List<Widget> icon_widget;
  final String title;

  NavbarTop({
    required this.title,
    this.icon_widget = const [],
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: blackTextStyle.copyWith(
                fontWeight: semibold, fontSize: 24),
          ),
          Row(
            children: icon_widget,
          ),
        ],
      ),
    );
  }
}