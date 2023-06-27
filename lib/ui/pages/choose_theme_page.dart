import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wibinx_app/blocs/cubit/auth_cubit.dart';
import 'package:wibinx_app/blocs/cubit/website_user_cubit.dart';
import 'package:wibinx_app/models/theme_model.dart';
import 'package:wibinx_app/models/user_model.dart';
import 'package:wibinx_app/services/auth_service.dart';
import 'package:wibinx_app/services/theme_service.dart';
import 'package:wibinx_app/shared/helper.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/pages/preview_theme_page.dart';
import 'package:wibinx_app/ui/widgets/card_theme_website.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_button_secondary.dart';

class ChooseThemePage extends StatefulWidget {
  const ChooseThemePage({Key? key}) : super(key: key);

  @override
  State<ChooseThemePage> createState() => _ChooseThemePageState();
}

class _ChooseThemePageState extends State<ChooseThemePage> {
  List<Widget> theme_widgets = [];

  int selected_theme_id = 0;

  @override
  void initState() {
    super.initState();
    print(theme_widgets);
  }

  Widget chooseCardTheme(int theme_id, String thumbnail) {
    return CardThemeWebsite(
      theme_id: theme_id,
      thumbnail: thumbnail,
      status: selected_theme_id == theme_id ? 'yes' : 'no',
      onTap: (value) {
        setState(() {
          selected_theme_id = value;
        });
      },
    );
  }

  List<List<ThemeModel>> groupArrayByEvenIndex<T>(List<ThemeModel> arr) {
    List<List<ThemeModel>> evenIndexGroup = [];
    for (int i = 0; i < arr.length; i += 2) {
      if (i + 1 < arr.length) {
        evenIndexGroup.add([arr[i], arr[i + 1]]);
      } else {
        evenIndexGroup.add([arr[i]]);
      }
    }
    return evenIndexGroup;
  }

  getTheme() async {
    List<ThemeModel> themes = await ThemeService().getTheme();

    return groupArrayByEvenIndex(themes);
  }

  generateListThemes() async {
    List<Widget> rows = [];

    List<List<ThemeModel>> themes = await getTheme();

    themes.forEach((item) {
      List<Widget> themes = [];

      item.forEach((theme) {
        themes.add(Flexible(
          flex: 1,
          child:
              chooseCardTheme(theme.id, theme.thumbnail_file['original_url']),
        ));

        if (themes.length == 1) {
          themes.add(SizedBox(
            width: 10,
          ));
        }
      });

      rows.add(Row(
        children: themes,
      ));

      theme_widgets = rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    WebsiteUserCubit websiteUserCubit = context.read<WebsiteUserCubit>();
    AuthCubit authCubit = context.read<AuthCubit>();

    final storage = const FlutterSecureStorage();

    Widget addChooseTheme() {
      return Column(
        children: theme_widgets,
      );
    }

    fetchAuthProfile() async {
      var userId = await storage.read(key: 'userId');

      authCubit.authProfile(int.parse(userId.toString()));
    }

    updateTheme() async {
      var userId = await storage.read(key: 'userId');

      if (userId != null) {
        var response =
            await AuthService().getAuthProfile(int.parse(userId.toString()));

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          UserModel user = UserModel.fromJson(data['data']);
          websiteUserCubit.update({
            'id': user.websites?[0]['id'],
            'theme_id': selected_theme_id,
            'name': user.websites?[0]['name'],
            'user_id': userId,
            'link_name': user.websites?[0]['link_name'],
            'description': user.websites?[0]['description'],
          });
        }
      }
    }

    return Scaffold(
      body: FutureBuilder(
        future: fetchAuthProfile(),
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Pilih Tema Website',
                  style: blackTextStyle.copyWith(
                      fontWeight: semibold, fontSize: 24),
                ),
                SizedBox(
                  height: 30,
                ),
                Flexible(
                  flex: 1,
                  child: ListView(
                    children: [
                      FutureBuilder(
                        future: generateListThemes(),
                        builder: (context, snapshot) {
                          return addChooseTheme();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    BlocBuilder(
                      bloc: authCubit,
                      builder: (context, state) {
                        if(state is AuthProfile) {

                          String previewUrl =  baseUrl + state.user.websites?[0]['link_name'];

                          return Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: CustomButton(
                              title: 'Preview Tema',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PreviewThemePage(
                                      themeId: selected_theme_id,
                                      previewUrl: previewUrl,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }

                        
                      },
                    ),

                    SizedBox(height: 80,)
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
