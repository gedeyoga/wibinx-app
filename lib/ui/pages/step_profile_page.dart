import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wibinx_app/blocs/cubit/website_user_cubit.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field_upload.dart';

class StepProfilePage extends StatefulWidget {
  StepProfilePage({Key? key}) : super(key: key);

  @override
  State<StepProfilePage> createState() => _StepProfilePageState();
}

class _StepProfilePageState extends State<StepProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController linkNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController logoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WebsiteUserCubit websiteUserCubit = context.read<WebsiteUserCubit>();
    final storage = const FlutterSecureStorage();


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
      return CustomFormFieldUpload(title: 'Logo Website');
    }

    Widget formCard() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            'Bagaimana Profil\nWebsitemu ?',
            style: blackTextStyle.copyWith(fontWeight: semibold, fontSize: 24),
          ),
          SizedBox(
            height: 30,
          ),
          inputNamaWebsite(),
          inputUrlWebsite(),
          Container(
            margin: EdgeInsets.only(bottom: 35),
            child: Text(
              'https://wibinx.com/' + linkNameController.text,
              style: primaryTextStyle,
            ),
          ),
          inputDescriptionWebsite(),
          inputUploadLogo(),
        ],
      );
    }

    void simpanWebsite() async {
      var userId = await storage.read(key: 'userId');

      websiteUserCubit.store({
        'user_id' : userId,
        'name' : nameController.text,
        'description' : descriptionController.text,
        'link_name' : linkNameController.text,
      });

    }

    return Scaffold(
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
                      if(state is WebsiteUserSuccess) {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/register-page/step-social-page',
                            (route) => false);
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
