import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/card_theme_website.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_button_secondary.dart';

class StepChooseThemePage extends StatefulWidget {
  const StepChooseThemePage({Key? key}) : super(key: key);

  @override
  State<StepChooseThemePage> createState() => _StepChooseThemePageState();
}

class _StepChooseThemePageState extends State<StepChooseThemePage> {
  @override
  Widget build(BuildContext context) {

    Widget chooseCardTheme(String thumbnail){
      return CardThemeWebsite(thumbnail:thumbnail);
    }

    Widget addChooseTheme() {
      return Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: chooseCardTheme('assets/theme_1.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 1,
                child: chooseCardTheme('assets/theme_2.png'),
              ),
            ],
          )
        ],
      );
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              'Pilih Tema\nWebsitemu',
              style:
                  blackTextStyle.copyWith(fontWeight: semibold, fontSize: 24),
            ),
            SizedBox(
              height: 30,
            ),
            Flexible(
              flex: 1,
              child: ListView(
                children: [
                  addChooseTheme(),
                  addChooseTheme(),
                  addChooseTheme(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: CustomButton(
                      title: 'Simpan & Lanjutkan',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/register-page/success-page', (route) => false);
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: CustomButtonSecondary(
                      title: 'Lewati',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/register-page/success-page', (route) => false);
                      },
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
