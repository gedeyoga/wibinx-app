import 'package:flutter/material.dart';
import 'package:wibinx_app/ui/pages/custom_link_page.dart';
import 'package:wibinx_app/ui/pages/form_link_page.dart';
import 'package:wibinx_app/ui/pages/login_page.dart';
import 'package:wibinx_app/ui/pages/main_page.dart';
import 'package:wibinx_app/ui/pages/marketplace_page.dart';
import 'package:wibinx_app/ui/pages/notification_page.dart';
import 'package:wibinx_app/ui/pages/register_page.dart';
import 'package:wibinx_app/ui/pages/social_media_page.dart';
import 'package:wibinx_app/ui/pages/splash_page.dart';
import 'package:wibinx_app/ui/pages/step_choose_theme_page.dart';
import 'package:wibinx_app/ui/pages/step_contact_page.dart';
import 'package:wibinx_app/ui/pages/step_marketplace_page.dart';
import 'package:wibinx_app/ui/pages/step_profile_page.dart';
import 'package:wibinx_app/ui/pages/step_social_page.dart';
import 'package:wibinx_app/ui/pages/success_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        '/register-page': (context) => RegisterPage(),
        '/login-page': (context) => LoginPage(),
        '/register-page/step-profile-page': (context) => StepProfilePage(),
        '/register-page/step-social-page': (context) => StepSocialPage(),
        '/register-page/step-contact-page': (context) => StepContactPage(),
        '/register-page/step-marketplace-page': (context) => StepMarketPlacePage(),
        '/register-page/step-choose-theme-page': (context) => StepChooseThemePage(),
        '/register-page/success-page': (context) => SuccessPage(),
        '/main-page': (context) => MainPage(),
        '/notification-page' : (context) => NotificationPage(),
        '/social-media-page' : (context) => SocialMediaPage(),
        '/custom-link-page' : (context) => CustomLinkPage(),
        '/marketplace-page' : (context) => MarketPlacePage(),
      },
    );
  }
}