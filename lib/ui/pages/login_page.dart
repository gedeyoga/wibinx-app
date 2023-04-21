import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget inputNama() {
      return CustomFormField(title: 'Nama', hintText: 'Cth: Jagoan Olshop');
    }

    Widget inputUsername() {
      return CustomFormField(title: 'Username', hintText: 'Cth: jagoan_olshop');
    }

    Widget inputPassword() {
      return CustomFormField(
        title: 'Password',
        hintText: 'Masukkan Password',
        obsecureText: true,
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 252,
            decoration: BoxDecoration(color: kPrimaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 114,
                  height: 49,
                  margin: EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image_logo_wibinx.png'),
                    ),
                  ),
                ),
                Container(
                  width: 187,
                  height: 138,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/image_login_ilustration.png'),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: 33, bottom: 40, left: defaultMargin, right: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Masuk ke Akun Wibinx',
                  style:
                      blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
                ),
                SizedBox(
                  height: 25,
                ),
                inputUsername(),
                inputPassword(),
                SizedBox(
                  height: 42,
                ),
                CustomButton(title: 'Masuk', onPressed: () {}),
                SizedBox(
                  height: 28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun ?',
                      style: greyTextStyle.copyWith(fontWeight: medium),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register-page');
                        },
                        child: Text(
                          'Daftar',
                          style: primaryTextStyle.copyWith(fontWeight: medium),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}