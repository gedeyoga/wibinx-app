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
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';

class StepMarketPlacePage extends StatelessWidget {
  const StepMarketPlacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LinkUserCubit linkUserCubit = context.read<LinkUserCubit>();

    TextEditingController tokopediaController = TextEditingController();
    TextEditingController bukalapakController = TextEditingController();
    TextEditingController lazadaController = TextEditingController();
    TextEditingController shopeeController = TextEditingController();

    var storage = const FlutterSecureStorage();


    Widget inputTokopedia() {
      return BlocConsumer(
        bloc: linkUserCubit,
        builder: (context, state) {
          return CustomFormField(
            title: 'Tokopedia',
            hintText: 'cth: tokopedia.com/namatokomu',
            controller: tokopediaController,
            validator: (data) => null,
          );
        },
        listener: (context, state) {},
      );
    }

    Widget inputShopee() {
      return BlocConsumer(
        bloc: linkUserCubit,
        builder: (context, state) {
          return CustomFormField(
            title: 'Shopee',
            hintText: 'cth: shopee.co.id/namatokomu',
            controller: shopeeController,
            validator: (data) => null,
          );
        },
        listener: (context, state) {},
      );
    }

    Widget inputBukalapak() {
      return BlocConsumer(
        bloc: linkUserCubit,
        builder: (context, state) {
          return CustomFormField(
            title: 'Bukalapak',
            hintText: 'cth: bukalapak.com/u/namatokomu',
            controller: bukalapakController,
            validator: (data) => null,
          );
        },
        listener: (context, state) {},
      );
    }

    Widget inputLazada() {
      return BlocConsumer(
        bloc: linkUserCubit,
        builder: (context, state) {
          return CustomFormField(
            title: 'Lazada',
            hintText: 'cth: lazada.co.id/shop/namatokomu',
            controller: lazadaController,
            validator: (data) => null,
          );
        },
        listener: (context, state) {},
      );
    }

    void simpanMarketPlace() async {
      List<LinkMasterModel> linkMasters =
          await LinkMasterService().getLinkMaster();
      var userId = await storage.read(key: 'userId');

      var response =
          await AuthService().getAuthProfile(int.parse(userId.toString()));
      var responseDecode = json.decode(response.body);

      List<Map<String, dynamic>> dataForm = [];

      List formType = [
        {
          'type': 'bukalapak',
          'url': bukalapakController.text,
        },
        {
          'type': 'tokopedia',
          'url': tokopediaController.text,
        },
        {
          'type': 'lazada',
          'url': lazadaController.text,
        },
        {
          'type': 'shopee',
          'url': shopeeController.text,
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
                  height: 40,
                ),
                Text(
                  'Apakah Anda Memiliki\nMarketplace ?',
                  style: blackTextStyle.copyWith(
                      fontWeight: semibold, fontSize: 24),
                ),
                SizedBox(
                  height: 30,
                ),
                inputTokopedia(),
                inputShopee(),
                inputBukalapak(),
                inputLazada(),
                BlocConsumer(
                  bloc: linkUserCubit,
                  builder: (context, state) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: CustomButton(
                        title: 'Simpan & Lanjutkan',
                        onPressed: () {
                          simpanMarketPlace();
                        },
                      ),
                    );
                  },
                  listener: (context, state) {
                    if(state is LinkUserSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/register-page/step-choose-theme-page',
                          (route) => false);
                    }
                  },
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CustomButtonSecondary(
                      title: 'Lewati',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/register-page/step-choose-theme-page',
                            (route) => false);
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
