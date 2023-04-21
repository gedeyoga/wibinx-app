import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field_upload.dart';

class StepProfilePage extends StatefulWidget {
  const StepProfilePage({Key? key}) : super(key: key);

  @override
  State<StepProfilePage> createState() => _StepProfilePageState();
}

class _StepProfilePageState extends State<StepProfilePage> {
  @override
  Widget build(BuildContext context) {
    Widget inputNamaWebsite() {
      return CustomFormField(
          title: 'Nama Website', hintText: 'cth: Jagoan Olshop');
    }

    Widget inputUrlWebsite() {
      return CustomFormField(
          title: 'Url Website', hintText: 'cth: jagoan_olshop');
    }

    Widget inputDescriptionWebsite() {
      return CustomFormField(
        title: 'Deskripsi Singkat',
        hintText: 'cth: jagoan_olshop',
        maxLines: 3,
      );
    }

    Widget inputUploadLogo() {
      return CustomFormFieldUpload(title: 'Logo Website');
    }

    Widget formCard() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            'Bagaimana Profil\nWebsitemu ?',
            style: blackTextStyle.copyWith(fontWeight: semibold, fontSize: 24),
          ),
          SizedBox(
            height: 30,
          ),
          inputNamaWebsite(),
          inputUrlWebsite(),
          Container(
            margin: EdgeInsets.only(bottom: 35),
            child: Text(
              'https://wibinx.com/',
              style: primaryTextStyle,
            ),
          ),
          inputDescriptionWebsite(),
          inputUploadLogo(),
        ],
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                formCard(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CustomButton(
                      title: 'Simpan & Lanjutkan',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/register-page/step-social-page', (route) => false);
                      },
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
