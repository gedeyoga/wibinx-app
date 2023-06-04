import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wibinx_app/blocs/cubit/auth_cubit.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = context.read<AuthCubit>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Widget inputNama() {
      String? validationError;
      return BlocConsumer(
        bloc: authCubit,
        builder: (context, state) {
          return CustomFormField(
            title: 'Nama',
            controller: nameController,
            hintText: 'Cth: Jagoan Olshop',
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
          if (state is AuthFailed) {
            if (state.error['errors']['name'] != null) {
              validationError = state.error['errors']['name'][0];
            }
          }
        },
      );
    }

    Widget inputEmail() {
      String? validationError;
      return BlocConsumer(
        bloc: authCubit,
        builder: (context, state) {
          return CustomFormField(
            title: 'Email',
            controller: emailController,
            hintText: 'Cth: jagoan_olshop',
            validator: (data) {
              if (data == null) {
                return 'Email tidak boleh kosong!';
              } else {
                return validationError;
              }
            },
          );
        },
        listener: (context, state) {
          validationError = null;
          if (state is AuthFailed) {
            if (state.error['errors']['email'] != null) {
              validationError = state.error['errors']['email'][0];
            }
          }
        },
      );
    }

    Widget inputPassword() {
      String? validationError;
      return BlocConsumer(
        bloc: authCubit,
        builder: (context, state) {
          return CustomFormField(
            title: 'Password',
            controller: passwordController,
            hintText: 'Masukkan Password',
            obsecureText: true,
            validator: (data) {
              if (data == null) {
                return 'Password tidak boleh kosong!';
              } else {
                return validationError;
              }
            },
          );
        },
        listener: (context, state) {
          validationError = null;
          if (state is AuthFailed) {
            if (state.error['errors']['password'] != null) {
              validationError = state.error['errors']['password'][0];
            }
          }
        },
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(color: kPrimaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 114,
                  height: 49,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image_logo_wibinx.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: 33, bottom: 40, left: defaultMargin, right: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daftar Akun Wibinx',
                  style:
                      blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
                ),
                SizedBox(
                  height: 25,
                ),
                inputNama(),
                inputEmail(),
                inputPassword(),
                SizedBox(
                  height: 42,
                ),
                BlocConsumer(
                  bloc: authCubit,
                  builder: (context, state) {
                    return CustomButton(
                        title: 'Daftar',
                        onPressed: () {
                          authCubit.register({
                            'name': nameController.text,
                            'email': emailController.text,
                            'password': passwordController.text
                          });
                        });
                  },
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/register-page/step-profile-page',
                          (Route<dynamic> route) => false);
                    }
                  },
                ),
                SizedBox(
                  height: 28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun ?',
                      style: greyTextStyle.copyWith(fontWeight: medium),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login-page');
                        },
                        child: Text(
                          'Masuk',
                          style: primaryTextStyle.copyWith(fontWeight: medium),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
