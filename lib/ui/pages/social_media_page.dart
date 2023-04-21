import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/pages/form_link_page.dart';
import 'package:wibinx_app/ui/widgets/card_widget.dart';

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sosial Media',
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
              title: 'Yoga Permana',
              description: 'https://facebook.com/gedeyoga43',
              icon: 'assets/icon_facebook_black.png',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormLinkPage(title: 'Facebook', icon: 'assets/icon_facebook.png')));
              },
            ),
            CardWidget(
              title: 'Yoga Permana',
              description: 'http://instagram.com/igdyogapermana',
              icon: 'assets/icon_instagram_black.png',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormLinkPage(title: 'Instagram', icon: 'assets/icon_instagram.png')));
              },
            ),
            CardWidget(
              title: 'Belum Ditentukan',
              description: 'Belum Ditentukan',
              icon: 'assets/icon_tiktok_black.png',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormLinkPage(title: 'Tiktok', icon: 'assets/icon_tiktok.png')));
              },
            ),
            CardWidget(
              title: 'Belum Ditentukan',
              description: 'Belum Ditentukan',
              icon: 'assets/icon_youtube_black.png',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormLinkPage(title: 'Youtube', icon: 'assets/icon_youtube.png')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
