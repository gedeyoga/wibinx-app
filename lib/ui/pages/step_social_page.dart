import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_button_secondary.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field_group.dart';

class StepSocialPage extends StatelessWidget {
  const StepSocialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget inputInstagram() {
      return CustomFormFieldGroup(
        title: 'Instagram',
        hintText: 'cth: igdyogapermana',
        icon: 'assets/icon_instagram.png',
      );
    }

    Widget inputTiktok() {
      return CustomFormFieldGroup(
        title: 'Tiktok',
        hintText: 'cth: igdyogapermana',
        icon: 'assets/icon_tiktok.png',
      );
    }

    Widget inputFacebook() {
      return CustomFormFieldGroup(
        title: 'Facebook',
        hintText: 'cth: igdyogapermana',
        icon: 'assets/icon_facebook.png',
      );
    }

    Widget inputYoutube() {
      return CustomFormFieldGroup(
        title: 'Youtube',
        hintText: 'cth: igdyogapermana',
        icon: 'assets/icon_youtube.png',
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Apa Saja Sosial\nMediamu ?',
                  style: blackTextStyle.copyWith(
                      fontWeight: semibold, fontSize: 24),
                ),
                SizedBox(
                  height: 30,
                ),
                inputInstagram(),
                inputTiktok(),
                inputFacebook(),
                inputYoutube(),
                Center(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: CustomButton(
                              title: 'Simpan & Lanjutkan',
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context, '/register-page/step-contact-page', (route) => false);
                              },
                            )),
                        Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: CustomButtonSecondary(
                              title: 'Lewati',
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context, '/register-page/step-contact-page', (route) => false);
                              },
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
