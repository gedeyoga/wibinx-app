import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wibinx_app/blocs/cubit/website_user_cubit.dart';
import 'package:wibinx_app/models/user_model.dart';
import 'package:wibinx_app/services/auth_service.dart';
import 'package:wibinx_app/shared/theme.dart';

class PreviewThemePage extends StatefulWidget {
  final int themeId;
  final String previewUrl;

  const PreviewThemePage({
    Key? key,
    required this.themeId,
    required this.previewUrl,

  }) : super(key: key);

  @override
  State<PreviewThemePage> createState() => _PreviewThemePageState();
}

class _PreviewThemePageState extends State<PreviewThemePage> {
  WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.previewUrl));
      // ..loadRequest(Uri.parse('https://wibinx.com/maniko'));
  }

  @override
  Widget build(BuildContext context) {
    final storage = const FlutterSecureStorage();


    void getDataAuth() async {
      var userId = await storage.read(key: 'userId');

      if (userId != null) {
        var response =
            await AuthService().getAuthProfile(int.parse(userId.toString()));
      }
    }

    updateTheme() async {
      var userId = await storage.read(key: 'userId');

      if (userId != null) {
        var response =
            await AuthService().getAuthProfile(int.parse(userId.toString()));

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          UserModel user = UserModel.fromJson(data['data']);
          WebsiteUserCubit().update({
            'id': user.websites?[0]['id'],
            'theme_id': widget.themeId,
            'name': user.websites?[0]['name'],
            'user_id': userId,
            'link_name': user.websites?[0]['link_name'],
            'description': user.websites?[0]['description'],
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Preview Tema',
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semibold),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.chevron_left,
            size: 35,
            color: kBlackColor,
          ),
          onTap: () {
            Navigator.pop(context, 'back');
          },
        ),
        actions: [
          TextButton(onPressed: (){
            showMyDialog(context, Text('Pemberitahuan'), [
                  Text('Apakah anda yakin ingin mengganti tema ?'),
                ], [
                  TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text('Batal' ,style: greyTextStyle,)),
                  TextButton(
                    onPressed: () {
                      updateTheme();
                      Navigator.pop(context, 'Cancel');
                      Navigator.pushNamedAndRemoveUntil(
                        context, '/register-page/success-page', (route) => false);
                    },
                    child: Text(
                      'Ganti Tema',
                      style: primaryTextStyle.copyWith(fontWeight: semibold),
                    ),
                  ),
                ]);
          }, child: Text('Ganti Tema'))
        ],
        backgroundColor: kWhiteColor,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body:WebViewWidget(controller: controller),
    );
  }
}
