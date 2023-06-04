import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wibinx_app/blocs/cubit/auth_cubit.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/card_menu_website.dart';
import 'package:wibinx_app/ui/widgets/custom_small_button.dart';
import 'package:wibinx_app/ui/widgets/navbar_top.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final storage = const FlutterSecureStorage();


  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = context.read<AuthCubit>();

    Widget cardProfileUser() {
      return BlocConsumer(
        bloc: authCubit,
        buildWhen: (previous, current) {
          
          return current is AuthProfile;
        },
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(
              bottom: 50,
            ),
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: kWhiteColor,
                border: Border.all(color: kOutlineColor),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15, top: 20),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(color: kGreyColor),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '-',
                        overflow: TextOverflow.ellipsis,
                        style: blackTextStyle.copyWith(
                          fontWeight: semibold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'https://wibinx.com/',
                        style: primaryTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dibuat pada',
                            style: outlineTextStyle.copyWith(fontWeight: light),
                          ),
                          Text(
                            '2023-09-02',
                            style: outlineTextStyle.copyWith(fontWeight: light),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomSmallButton(
                              title: 'Copy',
                              onPressed: () {},
                            ),
                            CustomSmallButton(
                              title: 'Lihat',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        listener: (context, state) {
          
        },
      );
    }

    void getDataAuth() async {
      var userId = await storage.read(key: 'userId');

      if (userId != null) {
        authCubit.authProfile(int.parse(userId));
      }
    }

    getDataAuth();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                NavbarTop(
                  title: 'Dashboard',
                  icon_widget: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/notification-page');
                      },
                      child: Icon(Icons.notifications, color: kBlackColor),
                    ),
                  ],
                ),
                cardProfileUser(),

                //Menu
                Text(
                  'Menu',
                  style: blackTextStyle.copyWith(
                      fontWeight: semibold, fontSize: 20),
                ),

                SizedBox(
                  height: 15,
                ),

                CardMenuWebsite(
                  title: 'Profil Website',
                  description: 'Pengaturan URL , Nama , deskripsi',
                  onTap: () => {},
                  icon: 'assets/icon_profile_website.png',
                ),
                CardMenuWebsite(
                  title: 'Link Sosial',
                  description: 'Pengaturan url facebook, tiktok, instagram',
                  onTap: () =>
                      {Navigator.pushNamed(context, '/social-media-page')},
                  icon: 'assets/icon_social_media.png',
                ),
                CardMenuWebsite(
                  title: 'Custom Link',
                  description: 'Pengaturan url ke website apapun',
                  onTap: () =>
                      {Navigator.pushNamed(context, '/custom-link-page')},
                  icon: 'assets/icon_custom_link.png',
                ),
                CardMenuWebsite(
                  title: 'Link Market',
                  description:
                      'Pengaturan URL , Tokopedia, Shopee, Bukalapak dan Lazada',
                  onTap: () =>
                      {Navigator.pushNamed(context, '/marketplace-page')},
                  icon: 'assets/icon_marketplace.png',
                ),
                CardMenuWebsite(
                  title: 'Kontak',
                  description: 'Pengaturan URL Whatsapp dan Line',
                  onTap: () => {},
                  icon: 'assets/icon_contact.png',
                ),
                CardMenuWebsite(
                  title: 'Produk',
                  description:
                      'Pengaturan produk yang akan ditampilkan di website',
                  onTap: () => {},
                  icon: 'assets/icon_product.png',
                ),

                SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
