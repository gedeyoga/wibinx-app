import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_button_secondary.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 232,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image_success.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Selamat Website Anda\nSudah Selesai !',
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semibold,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: CustomButton(
                      title: 'Lihat Website',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/register-page/success-page');
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: CustomButtonSecondary(
                      title: 'Menuju Tampilan Utama',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/main-page');
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
