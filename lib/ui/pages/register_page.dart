import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
            padding: EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(color: kPrimaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 114,
                  height: 49,
                  
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image_logo_wibinx.png'),
                    ),
                  ),
                ),
                // Container(
                //   width: 135,
                //   height: 141,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image:
                //           AssetImage('assets/image_register_ilustration.png'),
                //     ),
                //   ),
                // )
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
                  'Daftar Akun Wibinx',
                  style:
                      blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
                ),
                SizedBox(
                  height: 25,
                ),
                inputNama(),
                inputUsername(),
                inputPassword(),
                SizedBox(
                  height: 42,
                ),
                CustomButton(title: 'Daftar', onPressed: () {
                  Navigator.pushNamed(context, '/register-page/step-profile-page');
                }),
                SizedBox(height: 28,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun ?',
                      style: greyTextStyle.copyWith(fontWeight: medium),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, '/login-page');
                    }, child: Text('Masuk' , style: primaryTextStyle.copyWith(fontWeight: medium),))
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
