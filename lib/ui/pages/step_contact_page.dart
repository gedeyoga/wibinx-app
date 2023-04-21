import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_button_secondary.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field_group.dart';

class StepContactPage extends StatelessWidget {
  const StepContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget inputWhatsapp() {
      return CustomFormFieldGroup(
        title: 'Whatsapp',
        hintText: 'cth: +6202394809',
        icon: 'assets/icon_whatsapp.png',
      );
    }

    Widget inputLine() {
      return CustomFormFieldGroup(
        title: 'Tiktok',
        hintText: 'cth: @igdyogapermana',
        icon: 'assets/icon_line.png',
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
              'Dimana Pengunjung\nMenghubungi Anda ?',
              style:
                  blackTextStyle.copyWith(fontWeight: semibold, fontSize: 24),
            ),
            SizedBox(
              height: 30,
            ),
            inputWhatsapp(),
            inputLine(),
            Spacer(),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: CustomButton(
                      title: 'Simpan & Lanjutkan',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/register-page/step-marketplace-page', (route) => false);
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: CustomButtonSecondary(
                      title: 'Lewati',
                      onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/register-page/step-marketplace-page', (route) => false);
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
