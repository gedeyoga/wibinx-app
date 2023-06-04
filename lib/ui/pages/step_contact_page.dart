import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wibinx_app/blocs/cubit/link_user_cubit.dart';
import 'package:wibinx_app/models/link_master_model.dart';
import 'package:wibinx_app/services/auth_service.dart';
import 'package:wibinx_app/services/link_master_service.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_button_secondary.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field_group.dart';

class StepContactPage extends StatelessWidget {
  const StepContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LinkUserCubit linkUserCubit = context.read<LinkUserCubit>();

    TextEditingController whatsappController = TextEditingController();
    TextEditingController lineController = TextEditingController();

    var storage = const FlutterSecureStorage();

    Widget inputWhatsapp() {
      return BlocConsumer(
        bloc: linkUserCubit,
        builder: (context, state) {
          return CustomFormFieldGroup(
            title: 'Whatsapp',
            hintText: 'cth: +6202394809',
            icon: 'assets/icon_whatsapp.png',
            controller: whatsappController,
            validator: (data) => null,
          );
        },
        listener: (context, state) {},
      );
    }

    Widget inputLine() {
      return BlocConsumer(
        bloc: linkUserCubit,
        builder: (context, state) {
          return CustomFormFieldGroup(
            title: 'Tiktok',
            hintText: 'cth: @igdyogapermana',
            icon: 'assets/icon_line.png',
            controller: lineController,
            validator: (data) => null,
          );
        },
        listener: (context, state) {},
      );
    }

    void simpanContact() async {
      List<LinkMasterModel> linkMasters =
          await LinkMasterService().getLinkMaster();
      var userId = await storage.read(key: 'userId');

      var response =
          await AuthService().getAuthProfile(int.parse(userId.toString()));
      var responseDecode = json.decode(response.body);

      List<Map<String, dynamic>> dataForm = [];

      List formType = [
        {
          'type': 'whatsapp',
          'url': whatsappController.text,
        },
        {
          'type': 'line',
          'url': lineController.text,
        },
      ];

      formType.forEach((data) {
        try {
          LinkMasterModel linkMaster =
              linkMasters.firstWhere((item) => item.slug_link == data['type']);
          if (linkMaster != null) {
            dataForm.add({
              'website_user_id': responseDecode['data']['websites'][0]['id'],
              'link_master_id': linkMaster.id,
              'name': linkMaster.link_name,
              'url': data['url'],
            });
          }
        } catch (e) {}
      });

      linkUserCubit.updateMultipleLinkUser({
        'data': dataForm,
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
                  height: 80,
                ),
                Text(
                  'Dimana Pengunjung\nMenghubungi Anda ?',
                  style: blackTextStyle.copyWith(
                      fontWeight: semibold, fontSize: 24),
                ),
                SizedBox(
                  height: 30,
                ),
                inputWhatsapp(),
                inputLine(),
                // Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer(
                      bloc: linkUserCubit,
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: CustomButton(
                            title: 'Simpan & Lanjutkan',
                            onPressed: () {
                              simpanContact();
                            },
                          ),
                        );
                      },
                      listener: (context, state) {
                        if (state is LinkUserSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/register-page/step-marketplace-page',
                              (route) => false);
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
                              '/register-page/step-marketplace-page',
                              (route) => false);
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
