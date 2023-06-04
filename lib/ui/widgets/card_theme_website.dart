import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';

class CardThemeWebsite extends StatefulWidget {
  final String thumbnail;
  final int theme_id;
  final Function onTap;
  final String status;

  const CardThemeWebsite({
    Key? key,
    required this.theme_id,
    required this.thumbnail,
    required this.onTap,
    this.status = 'no',
  }) : super(key: key);

  @override
  State<CardThemeWebsite> createState() => _CardThemeWebsiteState();
}

class _CardThemeWebsiteState extends State<CardThemeWebsite> {
  // double borderWidth = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 260,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(color: kPrimaryColor, width: widget.status == 'yes' ? 4.0 : 0),
          image: DecorationImage(
            image: NetworkImage(widget.thumbnail ,headers: {
              'Connection': 'Keep-Alive',
              'Keep-Alive': 'timeout=5, max=1000'
            }),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () {
        // if(widget.status == 'yes') {
        //   setState(() {
        //     borderWidth = borderWidth == 4.0 ? 0 : 4.0;
        //   });
        // }
        widget.onTap(widget.theme_id);
      },
    );
  }
}
