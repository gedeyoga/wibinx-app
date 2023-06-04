import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {

      var token = await storage.read(key: 'token');

      if(token != null) {
        Navigator.of(context).pushNamedAndRemoveUntil('/main-page', (Route<dynamic> route) => false);
      } else {
        Navigator.pushNamed(context, '/register-page');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 280,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image_logo_wibinx.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
