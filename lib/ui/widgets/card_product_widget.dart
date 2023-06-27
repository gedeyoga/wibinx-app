import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/helper.dart';
import 'package:wibinx_app/shared/theme.dart';

class CardProductWidget extends StatelessWidget {
  final String title, imageUrl , status;
  final int price;
  final Function() onTap;

  const CardProductWidget({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
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
              width: 100,
              height: 70,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: kGreyColor,
                image: DecorationImage(
                  image: NetworkImage(imageUrl, headers: {
                    'Connection': 'Keep-Alive',
                    'Keep-Alive': 'timeout=5, max=1000'
                  }),
                  fit: BoxFit.cover,
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
                        fontSize: 16, fontWeight: bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    CurrencyFormat.convertToIdr(price, 1),
                    style: blackTextStyle.copyWith(fontWeight: light, fontSize: 25),
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
