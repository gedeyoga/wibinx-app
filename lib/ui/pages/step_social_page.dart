import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wibinx_app/blocs/cubit/link_user_cubit.dart';
import 'package:wibinx_app/models/link_master_model.dart';
import 'package:wibinx_app/models/link_user_model.dart';
import 'package:wibinx_app/services/auth_service.dart';
import 'package:wibinx_app/services/link_master_service.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_button_secondary.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field_group.dart';

class StepSocialPage extends StatelessWidget {
  StepSocialPage({Key? key}) : super(key: key);

  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    LinkUserCubit linkUserCubit = context.read<LinkUserCubit>();

    TextEditingController instagramController = TextEditingController();
    TextEditingController tiktokController = TextEditingController();
    TextEditingController facebookController = TextEditingController();
    TextEditingController youtubeController = TextEditingController();

    var storage = const FlutterSecureStorage();
    Widget inputInstagram() {
      return BlocConsumer(
        bloc: linkUserCubit,
        builder: (context, state) {
          return CustomFormFieldGroup(
            title: 'Instagram',
            hintText: 'cth: igdyogapermana',
            icon: 'assets/icon_instagram.png',
            controller: instagramController,
            validator: (data) => null,
          );
        },
        listener: (context, state) {},
      );
    }

    Widget inputTiktok() {
      return BlocConsumer(
        bloc: linkUserCubit,
        builder: (context, state) {
          return CustomFormFieldGroup(
            title: 'Tiktok',
            hintText: 'cth: igdyogapermana',
            icon: 'assets/icon_tiktok.png',
            controller: tiktokController,
            validator: (data) => null,
          );
        },
        listener: (context, state) {},
      );
    }

    Widget inputFacebook() {
      return BlocConsumer(
        bloc: linkUserCubit,
        builder: (context, state) {
          return CustomFormFieldGroup(
            title: 'Facebook',
            hintText: 'cth: igdyogapermana',
            icon: 'assets/icon_facebook.png',
            controller: facebookController,
            validator: (data) => null,
          );
        },
        listener: (context, state) {},
      );
    }

    Widget inputYoutube() {
      return BlocConsumer(
        bloc: linkUserCubit,
        builder: (context, state) {
          return CustomFormFieldGroup(
            title: 'Youtube',
            hintText: 'cth: igdyogapermana',
            icon: 'assets/icon_youtube.png',
            controller: youtubeController,
            validator: (data) => null,
          );
        },
        listener: (context, state) {},
      );
    }

    void simpanSocialMedia() async {
      List<LinkMasterModel> linkMasters =
          await LinkMasterService().getLinkMaster();
      var userId = await storage.read(key: 'userId');

      var response =
          await AuthService().getAuthProfile(int.parse(userId.toString()));
      var responseDecode = json.decode(response.body);

      List<Map<String , dynamic>> dataForm = [];

      List formType = [
        {
          'type': 'facebook',
          'url': facebookController.text,
        },
        {
          'type': 'instagram',
          'url': instagramController.text,
        },
        {
          'type': 'tiktok',
          'url': tiktokController.text,
        },
        {
          'type': 'youtube',
          'url': youtubeController.text,
        },
      ];

      formType.forEach((data) {
        try {
          LinkMasterModel linkMaster = linkMasters.firstWhere((item) => item.slug_link == data['type']);
          var links = responseDecode['data']['websites'][0]['link_users'] as List;

          Map<String,dynamic> linkUser = links.firstWhere((element) => element['link_master']['slug_link'] == data['type']);
          if(linkMaster != null) {
            dataForm.add({
              'website_user_id': responseDecode['data']['websites'][0]['id'],
              'link_master_id': linkMaster.id,
              'name': linkMaster.link_name,
              'url': data['url'],
              'id' : linkUser['id'],
              'section_id' : linkUser['section']['id'],
            });
          }
        } catch (e) {
          print(e);
        }
      });

      linkUserCubit.updateMultipleLinkUser({
        'data' : dataForm,
      });
    }

    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Apa Saja Sosial\nMediamu ?',
                  style: blackTextStyle.copyWith(
                      fontWeight: semibold, fontSize: 24),
                ),
                SizedBox(
                  height: 30,
                ),
                inputInstagram(),
                inputTiktok(),
                inputFacebook(),
                inputYoutube(),
                Center(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        BlocConsumer(
                          bloc: linkUserCubit,
                          builder: (context, state) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: CustomButton(
                                title: 'Simpan & Lanjutkan',
                                onPressed: () {
                                  simpanSocialMedia();
                                },
                              ),
                            );
                          },
                          listener: (context, state) {
                            if(state is LinkUserSuccess) {
                              Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/register-page/step-contact-page',
                                      (route) => false);
                            }

                            if(state is LinkUserFailed) {
                              print(state.error);
                            }
                          },
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: CustomButtonSecondary(
                              title: 'Lewati',
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/register-page/step-contact-page',
                                    (route) => false);
                              },
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
