import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';

class CardWidget extends StatelessWidget {
  final String title, description, icon , status;
  final Function() onTap;

  const CardWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    this.status = 'unread',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        decoration: BoxDecoration(
          color: status == 'readed' ? kGreyOverlay : kWhiteColor,
          border: Border.all(color: kOutlineColor),
        ),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(icon),
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semibold),
                  ),
                  Text(
                    description,
                    style: blackTextStyle.copyWith(fontWeight: light),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
