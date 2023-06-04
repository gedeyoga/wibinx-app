import 'package:flutter/material.dart';
import 'package:wibinx_app/blocs/cubit/auth_cubit.dart';
import 'package:wibinx_app/blocs/cubit/link_user_cubit.dart';
import 'package:wibinx_app/blocs/cubit/page_cubit.dart';
import 'package:wibinx_app/blocs/cubit/website_user_cubit.dart';
import 'package:wibinx_app/ui/pages/custom_link_page.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => WebsiteUserCubit(),
        ),
        BlocProvider(
          create: (context) => LinkUserCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/register-page': (context) => const RegisterPage(),
          '/login-page': (context) => LoginPage(),
          '/register-page/step-profile-page': (context) => StepProfilePage(),
          '/register-page/step-social-page': (context) => StepSocialPage(),
          '/register-page/step-contact-page': (context) => const StepContactPage(),
          '/register-page/step-marketplace-page': (context) => const StepMarketPlacePage(),
          '/register-page/step-choose-theme-page': (context) => const StepChooseThemePage(),
          '/register-page/success-page': (context) => const SuccessPage(),
          '/main-page': (context) => const MainPage(),
          '/notification-page': (context) => const NotificationPage(),
          '/social-media-page': (context) => const SocialMediaPage(),
          '/custom-link-page': (context) => const CustomLinkPage(),
          '/marketplace-page': (context) => const MarketPlacePage(),
        },
      ),
    );
  }
}