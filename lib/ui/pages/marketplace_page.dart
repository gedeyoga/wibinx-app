import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wibinx_app/blocs/cubit/auth_cubit.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/pages/form_link_page.dart';
import 'package:wibinx_app/ui/widgets/card_widget.dart';

class MarketPlacePage extends StatelessWidget {
  const MarketPlacePage({Key? key}) : super(key: key);

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
          'Marketplace',
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

                //Shopee
                BlocBuilder<AuthCubit, AuthState>(
                  bloc: authCubit,
                  builder: (context, state) {
                    if (state is AuthProfile) {
                      List link_users = state.user.websites?[0]['link_users'];
                      var link = link_users.firstWhere((link_user) {
                        if (link_user['link_master'] != null) {
                          return link_user['link_master']['slug_link'] ==
                              'shopee';
                        }
                        return false;
                      }, orElse: () => null);

                      var sections =
                          state.user.websites?[0]['sections'] as List;
                      var section = sections.firstWhere(
                          (section) => section['slug'] == 'marketplace');
                      section_id = section['id'];

                      return CardWidget(
                        title: link['name'] != null ? link['name'] : 'Belum ditentukan',
                        description: link['name'] != null
                            ? link['link_master']['main_url'] + link['url'].toString()
                            : 'Belum ditentukan',
                        icon: 'assets/icon_shopee_black.png',
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormLinkPage(
                                title: 'Shopee',
                                icon: 'assets/icon_shopee.png',
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
                      title: 'Belum Ditentukan',
                      description: 'Belum ditentukan',
                      icon: 'assets/icon_shopee_black.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormLinkPage(
                              title: 'Shopee',
                              icon: 'assets/icon_shopee.png',
                              website_user_id: 0,
                              section_id: section_id,

                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                //Tokopedia
                BlocBuilder<AuthCubit, AuthState>(
                  bloc: authCubit,
                  builder: (context, state) {
                    if (state is AuthProfile) {
                      List link_users = state.user.websites?[0]['link_users'];
                      var link = link_users.firstWhere((link_user) {
                        if (link_user['link_master'] != null) {
                          return link_user['link_master']['slug_link'] ==
                              'tokopedia';
                        }
                        return false;
                      }, orElse: () => null);

                      return CardWidget(
                        title: link['name'] != null ? link['name'] : 'Belum ditentukan',
                        description: link['name'] != null
                            ? link['link_master']['main_url'] + link['url'].toString()
                            : 'Belum ditentukan',
                        icon: 'assets/icon_tokopedia_black.png',
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormLinkPage(
                                title: 'Tokopedia',
                                icon: 'assets/icon_tokopedia.png',
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
                      title: 'Belum Ditentukan',
                      description: 'Belum ditentukan',
                      icon: 'assets/icon_tokopedia_black.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormLinkPage(
                              title: 'Tokopedia',
                              icon: 'assets/icon_tokopedia.png',
                              website_user_id: 0,
                              section_id: section_id,

                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                BlocBuilder<AuthCubit, AuthState>(
                  bloc: authCubit,
                  builder: (context, state) {
                    if (state is AuthProfile) {
                      List link_users = state.user.websites?[0]['link_users'];
                      var link = link_users.firstWhere((link_user) {
                        if (link_user['link_master'] != null) {
                          return link_user['link_master']['slug_link'] ==
                              'bukalapak';
                        }
                        return false;
                      }, orElse: () => null);

                      return CardWidget(
                        title: link['name'] != null ? link['name'] : 'Belum ditentukan',
                        description: link['name'] != null
                            ? link['link_master']['main_url'] + link['url'].toString()
                            : 'Belum ditentukan',
                        icon: 'assets/icon_bukalapak_black.png',
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormLinkPage(
                                title: 'Bukalapak',
                                icon: 'assets/icon_bukalapak.png',
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
                      title: 'Belum Ditentukan',
                      description: 'Belum ditentukan',
                      icon: 'assets/icon_bukalapak_black.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormLinkPage(
                              title: 'Bukalapak',
                              icon: 'assets/icon_bukalapak.png',
                              website_user_id: 0,
                              section_id: section_id,

                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                
                BlocBuilder<AuthCubit, AuthState>(
                  bloc: authCubit,
                  builder: (context, state) {
                    if (state is AuthProfile) {
                      List link_users = state.user.websites?[0]['link_users'];
                      var link = link_users.firstWhere((link_user) {
                        if (link_user['link_master'] != null) {
                          return link_user['link_master']['slug_link'] ==
                              'lazada';
                        }
                        return false;
                      }, orElse: () => null);

                      return CardWidget(
                        title: link['name'] != null ? link['name'] : 'Belum ditentukan',
                        description: link['name'] != null
                            ? link['link_master']['main_url'] + link['url'].toString().toString()
                            : 'Belum ditentukan',
                        icon: 'assets/icon_lazada_black.png',
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormLinkPage(
                                title: 'Bukalapak',
                                icon: 'assets/icon_lazada.png',
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
                      title: 'Belum Ditentukan',
                      description: 'Belum ditentukan',
                      icon: 'assets/icon_lazada_black.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormLinkPage(
                              title: 'Tokopedia',
                              icon: 'assets/icon_lazada.png',
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
