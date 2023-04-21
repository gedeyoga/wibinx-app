import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_button_secondary.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field_upload.dart';

class StepMarketPlacePage extends StatelessWidget {
  const StepMarketPlacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget inputTokopedia() {
      return CustomFormField(
        title: 'Tokopedia',
        hintText: 'cth: tokopedia.com/namatokomu',
      );
    }

    Widget inputShopee() {
      return CustomFormField(
        title: 'Shopee',
        hintText: 'cth: shopee.co.id/namatokomu',
      );
    }

    Widget inputBukalapak() {
      return CustomFormField(
        title: 'Bukalapak',
        hintText: 'cth: bukalapak.com/u/namatokomu',
      );
    }

    Widget inputLazada() {
      return CustomFormField(
        title: 'Lazada',
        hintText: 'cth: lazada.co.id/shop/namatokomu',
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
                  'Apakah Anda Memiliki\nMarketplace ?',
                  style: blackTextStyle.copyWith(
                      fontWeight: semibold, fontSize: 24),
                ),
                SizedBox(
                  height: 30,
                ),
                inputTokopedia(),
                inputShopee(),
                inputBukalapak(),
                inputLazada(),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: CustomButton(
                    title: 'Simpan & Lanjutkan',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/register-page/step-choose-theme-page', (route) => false);
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CustomButtonSecondary(
                      title: 'Lewati',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/register-page/step-choose-theme-page', (route) => false);
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
