import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wibinx_app/blocs/cubit/auth_cubit.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_button_secondary.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';
import 'package:wibinx_app/ui/widgets/navbar_top.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUserPage extends StatelessWidget {
  ProfileUserPage({Key? key}) : super(key: key);
  final storage = const FlutterSecureStorage();

  

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = context.read<AuthCubit>();

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController rePasswordController = TextEditingController();

    void getDataAuth() async {
      var userId = await storage.read(key: 'userId');

      if (userId != null) {
        authCubit.authProfile(int.parse(userId));
      }
    }

    Widget inputNama() {
      return BlocListener(
        bloc: authCubit,
        listener: (context, state) {
          if (state is AuthProfile) {
            nameController.text = state.user.name;
          }
        },
        child: BlocBuilder(
          bloc: authCubit,
          builder: (context, state) {
            return CustomFormField(
              title: 'Nama',
              hintText: 'Cth: Yoga Permana',
              validator: (value) => null,
              controller: nameController,
            );
          },
        ),
      );
    }

    Widget inputEmail() {
      return BlocListener(
        bloc: authCubit,
        listener: (context, state) {
          if (state is AuthProfile) {
            emailController.text = state.user.email;
          }
        },
        child: BlocBuilder(
          bloc: authCubit,
          builder: (context, state) {
            return CustomFormField(
              title: 'Email',
              hintText: 'Cth: email@example.com',
              validator: (value) => null,
              controller: emailController,
            );
          },
        ),
      );
    }

    Widget inputPassword() {
      return CustomFormField(
        title: 'Password Baru',
        controller: passwordController,
        hintText: 'Masukkan password baru',
        validator: (value) => null,
        obsecureText: true,
      );
    }

    Widget inputRePassword() {
      return CustomFormField(
        title: 'Ulangi Password',
        controller: rePasswordController,
        hintText: 'Ulangi password baru',
        obsecureText: true,
        validator: (value) {
          if (passwordController.text != value) {
            return 'Password tidak sama!';
          }

          return null;
        },
      );
    }

    void updateUser() async {
      var userId = await storage.read(key: 'userId');

      authCubit.updateUser(
        userId.toString(),
        nameController.text,
        emailController.text,
        passwordController.text,
        passwordController.text == rePasswordController.text,
      );
    }

    getDataAuth();

    return Scaffold(
      body: Stack(
        children: [
          BlocConsumer(
            bloc: authCubit,
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ListView(
                  children: [
                    NavbarTop(title: 'Profile'),
                    inputNama(),
                    inputEmail(),
                    inputPassword(),
                    inputRePassword(),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: CustomButton(
                          title: 'Simpan',
                          onPressed: () {
                            updateUser();
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 120),
                      child: CustomButtonSecondary(
                          title: 'Logout',
                          onPressed: () {
                            authCubit.logout();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                          }),
                    ),
                  ],
                ),
              );
            },
            listener: (context, state) {
              if(state is AuthUpdate) {
                print(state.message);
              }
            },
          )
        ],
      ),
    );
  }
}
