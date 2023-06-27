import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wibinx_app/blocs/cubit/link_user_cubit.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_button_delete_secondary.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field_group.dart';

class FormLinkPage extends StatelessWidget {
  final String title, icon;
  final Map<String, dynamic>? data;
  final int website_user_id;
  final int? section_id;

  const FormLinkPage({
    Key? key,
    required this.title,
    required this.icon,
    this.data = null,
    required this.website_user_id,
    this.section_id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LinkUserCubit linkUserCubit = LinkUserCubit();

    TextEditingController nameController = TextEditingController();
    TextEditingController linkController = TextEditingController();

    nameController.text = data?['name'] ?? '';
    linkController.text = data?['url'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
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
        backgroundColor: kWhiteColor,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Stack(
          children: [
            ListView(
              children: [
                CustomFormField(
                  title: 'Nama',
                  hintText: 'Masukkan Nama Link..',
                  validator: (data) => null,
                  controller: nameController,
                ),
                CustomFormFieldGroup(
                  title: 'Link ' + title,
                  hintText: 'Masukan link...',
                  icon: icon,
                  validator: (data) => null,
                  controller: linkController,
                ),
              ],
            ),
            BlocListener(
              bloc: linkUserCubit,
              listener: (context, state) {
                if (state is LinkUserSuccess) {
                  Navigator.pop(context, 'back');
                }

                if(state is LinkUserDeleted) {
                  Navigator.pop(context, 'back');
                }
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      title: 'Simpan',
                      onPressed: () {
                        if (data?['id'] != null) {
                          linkUserCubit.updateLinkUser({
                            'id': data?['id'],
                            'website_user_id': website_user_id,
                            'link_master_id': data?['link_master_id'],
                            'name': nameController.text,
                            'url': linkController.text,
                            'section_id': section_id,
                          });
                        } else {
                          linkUserCubit.updateMultipleLinkUser({
                            'data': [
                              {
                                'website_user_id': website_user_id,
                                'link_master_id': data?['link_master_id'],
                                'name': nameController.text,
                                'url': linkController.text,
                                'section_id': section_id,
                              }
                            ]
                          });
                        }
                      },
                      margin: EdgeInsets.only(bottom: 25),
                    ),
                    data?['id'] != null && data?['link_master_id'] == null ? CustomButtonDeleteSecondary(
                      title: 'Hapus Link',
                      onPressed: () {
                        showMyDialog(
                          context,
                          Text('Pemberitahuan'),
                          [Text('Apakah anda yakin menghapus link?')],
                          [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context , 'Cancel');
                              },
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                linkUserCubit.deleteLinkUser(data?['id']);
                                Navigator.pop(context , 'HapusLink');
                              },
                              child: Text(
                                'Hapus',
                                style: dangerTextStyle,
                              ),
                            ),
                          ],
                        );
                      },
                      margin: EdgeInsets.only(bottom: 25),
                    ) : SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
