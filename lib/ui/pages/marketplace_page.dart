import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/pages/form_link_page.dart';
import 'package:wibinx_app/ui/widgets/card_widget.dart';

class MarketPlacePage extends StatelessWidget {
  const MarketPlacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Marketplace',
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semibold),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.chevron_left,
            size: 35,
            color: kBlackColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kWhiteColor,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            CardWidget(
              title: 'Belum Ditentukan',
              description: 'Belum ditentukan',
              icon: 'assets/icon_shopee_black.png',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormLinkPage(title: 'Shopee', icon: 'assets/icon_shopee.png')));
              },
            ),
            CardWidget(
              title: 'Tokopedia',
              description: 'http://tokopedia.com/aksm',
              icon: 'assets/icon_tokopedia_black.png',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormLinkPage(
                            title: 'Tokopedia', icon: 'assets/icon_tokopedia.png')));
              },
            ),
            CardWidget(
              title: 'Bukalapak',
              description: 'Belum Ditentukan',
              icon: 'assets/icon_bukalapak_black.png',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormLinkPage(title: 'Bukalapak', icon: 'assets/icon_bukalapak.png')));
              },
            ),
            CardWidget(
              title: 'Lazada',
              description: 'Belum Ditentukan',
              icon: 'assets/icon_lazada_black.png',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormLinkPage(title: 'Lazada', icon: 'assets/icon_lazada.png')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
