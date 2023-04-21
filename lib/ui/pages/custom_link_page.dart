import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/card_widget.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';

class CustomLinkPage extends StatelessWidget {
  const CustomLinkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Custom Link',
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
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                CardWidget(
                  title: 'Cek Katalog Terbaru',
                  description: 'https://bit.ly/katalogfee',
                  icon: 'assets/icon_profile_website.png',
                  onTap: () {},
                ),
                CardWidget(
                  title: 'Cek Promo Terbaru',
                  description: 'https://bit.ly/katalogsdfsk',
                  icon: 'assets/icon_profile_website.png',
                  onTap: () {},
                ),
                CardWidget(
                  title: 'Cek Katalog Terbaru',
                  description: 'https://bit.ly/katalogfee',
                  icon: 'assets/icon_profile_website.png',
                  onTap: () {},
                ),
                CardWidget(
                  title: 'Cek Promo Terbaru',
                  description: 'https://bit.ly/katalogsdfsk',
                  icon: 'assets/icon_profile_website.png',
                  onTap: () {},
                ),
                CardWidget(
                  title: 'Cek Katalog Terbaru',
                  description: 'https://bit.ly/katalogfee',
                  icon: 'assets/icon_profile_website.png',
                  onTap: () {},
                ),
                CardWidget(
                  title: 'Cek Promo Terbaru',
                  description: 'https://bit.ly/katalogsdfsk',
                  icon: 'assets/icon_profile_website.png',
                  onTap: () {},
                ),
                CardWidget(
                  title: 'Cek Katalog Terbaru',
                  description: 'https://bit.ly/katalogfee',
                  icon: 'assets/icon_profile_website.png',
                  onTap: () {},
                ),
                CardWidget(
                  title: 'Cek Promo Terbaru',
                  description: 'https://bit.ly/katalogsdfsk',
                  icon: 'assets/icon_profile_website.png',
                  onTap: () {},
                ),
                CardWidget(
                  title: 'Cek Katalog Terbaru',
                  description: 'https://bit.ly/katalogfee',
                  icon: 'assets/icon_profile_website.png',
                  onTap: () {},
                ),
                CardWidget(
                  title: 'Cek Promo Terbaru',
                  description: 'https://bit.ly/katalogsdfsk',
                  icon: 'assets/icon_profile_website.png',
                  onTap: () {},
                ),

                SizedBox(height: 120),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(color: kWhiteColor),
                padding: EdgeInsets.symmetric(vertical: 15),
                child: CustomButton(title: 'Tambah Link', onPressed: () {},),
              ),
            )
          ],
        ),
      ),
    );
  }
}
