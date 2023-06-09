import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/pages/form_link_page.dart';
import 'package:wibinx_app/ui/widgets/card_widget.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wibinx_app/blocs/cubit/auth_cubit.dart';

class CustomLinkPage extends StatelessWidget {
  const CustomLinkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = const FlutterSecureStorage();
    AuthCubit authCubit = context.read<AuthCubit>();
    int section_id = 0;
    int website_user_id = 0;



    fetchAuthProfile() async {
      var userId = await storage.read(key: 'userId');

      authCubit.authProfile(int.parse(userId.toString()));
    }

    List<Widget> generateList(List customLinks) {
      List<Widget> widgets = [];

      customLinks.forEach((element) {
        widgets.add(CardWidget(
          title: element['name'] ?? '',
          description: element['url'] ?? '',
          icon: 'assets/icon_profile_website.png',
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormLinkPage(
                  title: 'Custom',
                  icon: 'assets/icon_profile_website.png',
                  website_user_id: website_user_id,
                  section_id: section_id,
                  data: element,
                ),
              ),
            );

            fetchAuthProfile();
          },
        ));
      });
      

      return widgets;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Custom Link',
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semibold),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.chevron_left,
            size: 35,
            color: kBlackColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kWhiteColor,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: FutureBuilder(
            future: fetchAuthProfile(),
            builder: (context, snapshot) {
              return Stack(
                children: [
                  BlocBuilder(
                    bloc: authCubit,
                    builder: (context, state) {
                      if (state is AuthProfile) {
                        List linkUser = state.user.websites?[0]['link_users'];
                        List customLinks = linkUser
                            .where((element) =>
                                element.length > 0 &&
                                (element['link_master_id'] == null ||
                                    element['link_master_id'] == 0))
                            .toList();

                        var sections = state.user.websites?[0]['sections'] as List;
                        var section = sections.firstWhere((section) => section['slug'] == 'custom-link');
                        section_id = section['id'];

                        if(customLinks.length > 0) {
                          if (customLinks.length == 1) {
                            if(customLinks[0]['name'] != null) {
                              return ListView(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ...generateList(customLinks),
                                  SizedBox(height: 120),
                                ],
                              );
                            } 
                          } else {
                            return ListView(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                ...generateList(customLinks),
                                SizedBox(height: 120),
                              ],
                            );
                          }
                        }
                      }
                      return Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: kGreyColor, width: 1),
                        ),
                        child: Center(child: Text('Tidak ada data')),
                      );
                    },
                  ),
                  BlocBuilder(
                    bloc: authCubit,
                    builder: (context, state) {
                      if (state is AuthProfile) {
                        website_user_id = state.user.websites?[0]['id'];
                      }

                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(color: kWhiteColor),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: CustomButton(
                            title: 'Tambah Link',
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormLinkPage(
                                    title: 'Custom',
                                    icon: 'assets/icon_profile_website.png',
                                    website_user_id: website_user_id,
                                    section_id: section_id,
                                  ),
                                ),
                              );

                              fetchAuthProfile();
                            },
                          ),
                        ),
                      );
                    },
                  )
                ],
              );
            },
          )),
    );
  }
}
