import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wibinx_app/blocs/cubit/auth_cubit.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/pages/form_link_page.dart';
import 'package:wibinx_app/ui/widgets/card_widget.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = const FlutterSecureStorage();
    AuthCubit authCubit = context.read<AuthCubit>();
    int section_id = 0;

    fetchAuthProfile() async {
      var userId = await storage.read(key: 'userId');

      authCubit.authProfile(int.parse(userId.toString()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kontak',
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
      body: FutureBuilder(
        future: fetchAuthProfile(),
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                SizedBox(
                  height: 15,
                ),

                // Facebook
                BlocBuilder<AuthCubit, AuthState>(
                  bloc: authCubit,
                  builder: (context, state) {
                    if (state is AuthProfile) {
                      List link_users = state.user.websites?[0]['link_users'];
                      var link = link_users.firstWhere((link_user) {
                        if (link_user['link_master'] != null) {
                          return link_user['link_master']['slug_link'] ==
                              'whatsapp';
                        }
                        return false;
                      }, orElse: () => null);

                      var sections =
                          state.user.websites?[0]['sections'] as List;
                      var section = sections.firstWhere(
                          (section) => section['slug'] == 'contact');
                      section_id = section['id'];

                      return CardWidget(
                        title: link != null ? link['name'] : 'Belum ditentukan',
                        description: link != null
                            ? link['link_master']['main_url'] + link['url'].toString()
                            : 'Belum ditentukan',
                        icon: 'assets/icon_facebook_black.png',
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormLinkPage(
                                title: 'Whatsapp',
                                icon: 'assets/icon_whatsapp.png',
                                data: link,
                                website_user_id: state.user.websites?[0]['id'],
                                section_id: section_id,
                              ),
                            ),
                          );

                          fetchAuthProfile();

                        },
                      );
                    }
                    return CardWidget(
                      title: 'Belum ditentukan',
                      description: 'Belum ditentukan',
                      icon: 'assets/icon_facebook_black.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormLinkPage(
                              title: 'Whatsapp',
                              icon: 'assets/icon_whatsapp.png',
                              website_user_id: 0,
                              section_id: section_id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                //Line
                BlocBuilder<AuthCubit, AuthState>(
                  bloc: authCubit,
                  builder: (context, state) {
                    if (state is AuthProfile) {
                      List link_users = state.user.websites?[0]['link_users'];
                      var link = link_users.firstWhere((link_user) {
                        if (link_user['link_master'] != null) {
                          return link_user['link_master']['slug_link'] ==
                              'line';
                        }
                        return false;
                      }, orElse: () => null);

                      return CardWidget(
                        title: link != null ? link['name'] : 'Belum ditentukan',
                        description: link != null
                            ? link['link_master']['main_url'] + link['url'].toString()
                            : 'Belum ditentukan',
                        icon: 'assets/icon_instagram_black.png',
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormLinkPage(
                                title: 'Line',
                                icon: 'assets/icon_line.png',
                                data: link,
                                website_user_id: state.user.websites?[0]['id'],
                                section_id: section_id,

                              ),
                            ),
                          );

                          fetchAuthProfile();

                        },
                      );
                    }

                    return CardWidget(
                      title: 'Belum ditentukn',
                      description: 'Belum ditentukan',
                      icon: 'assets/icon_instagram_black.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormLinkPage(
                              title: 'Instagram',
                              icon: 'assets/icon_line.png',
                              website_user_id: 0,
                              section_id: section_id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}