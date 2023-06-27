import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wibinx_app/blocs/cubit/auth_cubit.dart';
import 'package:wibinx_app/blocs/cubit/website_user_cubit.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field_upload.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? websiteId;
    TextEditingController nameController = TextEditingController();
    TextEditingController linkNameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    XFile? logo;

    WebsiteUserCubit websiteUserCubit = context.read<WebsiteUserCubit>();
    final storage = const FlutterSecureStorage();

    AuthCubit authCubit = context.read<AuthCubit>();
    int section_id = 0;
    int theme_id = 0;

    fetchAuthProfile() async {
      var userId = await storage.read(key: 'userId');

      authCubit.authProfile(int.parse(userId.toString()));
    }

    Widget inputNamaWebsite() {
      String? validationError;
      return BlocConsumer(
        bloc: websiteUserCubit,
        builder: (context, state) {
          return CustomFormField(
            title: 'Nama Website',
            controller: nameController,
            hintText: 'cth: Jagoan Olshop',
            validator: (data) {
              if (data == null) {
                return 'Nama tidak boleh kosong!';
              } else {
                return validationError;
              }
            },
          );
        },
        listener: (context, state) {
          validationError = null;
          if (state is WebsiteUserFailed) {
            if (state.error['errors']['name'] != null) {
              validationError = state.error['errors']['name'][0];
            }
          }
        },
      );
    }

    Widget inputUrlWebsite() {
      String? validationError;
      return BlocConsumer(
        bloc: websiteUserCubit,
        builder: (context, state) {
          return CustomFormField(
            title: 'Url Website',
            controller: linkNameController,
            hintText: 'cth: jagoan_olshop',
            onChanged: (value) {
              websiteUserCubit.linkType(value);
            },
            validator: (data) {
              if (data == null) {
                return 'Url website tidak boleh kosong!';
              } else {
                return validationError;
              }
            },
          );
        },
        listener: (context, state) {
          validationError = null;
          if (state is WebsiteUserFailed) {
            if (state.error['errors']['link_name'] != null) {
              validationError = state.error['errors']['link_name'][0];
            }
          }
        },
      );
    }

    Widget inputDescriptionWebsite() {
      String? validationError;
      return BlocConsumer(
        bloc: websiteUserCubit,
        builder: (context, state) {
          return CustomFormField(
            title: 'Deskripsi Singkat',
            controller: descriptionController,
            hintText: 'cth: jagoan_olshop',
            maxLines: 3,
            validator: (data) {
              if (data == null) {
                return 'Deskripsi tidak boleh kosong!';
              } else {
                return validationError;
              }
            },
          );
        },
        listener: (context, state) {
          validationError = null;
          if (state is WebsiteUserFailed) {
            if (state.error['errors']['description'] != null) {
              validationError = state.error['errors']['description'][0];
            }
          }
        },
      );
    }

    Widget inputUploadLogo() {
      return BlocBuilder(
        bloc: authCubit,
        builder: (context, state) {
          var imgUrl;

          if(state is AuthProfile) {
            imgUrl = state.user.websites?[0]['logo']['original_url'];
          }
          return CustomFormFieldUpload(
            title: 'Logo Website',
            onUploaded: (image) {
              logo = image;
            },
            imageUrl: imgUrl,
          );
        },
      );
    }

    Widget formCard() {
      return FutureBuilder(
        future: fetchAuthProfile(),
        builder: (context, snapshot) {
          return BlocListener(
            bloc: authCubit,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputNamaWebsite(),
                inputUrlWebsite(),
                Container(
                  margin: EdgeInsets.only(bottom: 35),
                  child: BlocBuilder(
                    bloc: websiteUserCubit,
                    builder: (context, state) {
                      if (state is LinkNameTyping) {
                        return Text(
                          'https://wibinx.com/' + state.link,
                          style: primaryTextStyle,
                        );
                      }

                      return BlocBuilder(
                        bloc: authCubit,
                        builder: (context, state) {
                          return Text(
                            'https://wibinx.com/' + linkNameController.text,
                            style: primaryTextStyle,
                          );
                        },
                      );
                    },
                  ),
                ),
                inputDescriptionWebsite(),
                inputUploadLogo(),
              ],
            ),
            listener: (context, state) {
              if (state is AuthProfile) {
                nameController.text = state.user.websites?[0]['name'] ?? '';
                linkNameController.text =
                    state.user.websites?[0]['link_name'] ?? '';
                descriptionController.text =
                    state.user.websites?[0]['description'] ?? '';

                websiteId = state.user.websites?[0]['id'];

                var sections = state.user.websites?[0]['sections'] as List;
                var section = sections
                    .firstWhere((section) => section['slug'] == 'custom-link');
                section_id = section['id'];

                theme_id = state.user.websites?[0]['theme_id'];
              }
            },
          );
        },
      );
    }

    void simpanWebsite() async {
      var userId = await storage.read(key: 'userId');

      await websiteUserCubit.update({
        'id': websiteId,
        'user_id': userId,
        'name': nameController.text,
        'description': descriptionController.text,
        'link_name': linkNameController.text,
        'logo': logo,
        'section_id': section_id,
        'theme_id' : theme_id,
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Website',
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
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                formCard(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BlocConsumer(
                    bloc: websiteUserCubit,
                    builder: (context, state) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: CustomButton(
                          title: 'Simpan & Lanjutkan',
                          onPressed: () {
                            simpanWebsite();
                          },
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is WebsiteUserSuccess) {
                        print(state);
                        final snackBar = SnackBar(
                          content: Text(state.message),
                          action: SnackBarAction(
                            label: 'Tutup',
                            onPressed: () {},
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
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
