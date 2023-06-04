import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wibinx_app/blocs/cubit/auth_cubit.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = context.read<AuthCubit>();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Widget inputUsername() {
      String? validationError;

      return MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              validationError = null;
              if (state is AuthFailed) {
                if (state.error['errors']['email'] != null) {
                  validationError = state.error['errors']['email'][0];
                }
              }
            },
          )
        ],
        child: BlocBuilder(
          bloc: authCubit,
          builder: (context, state) {
            return CustomFormField(
              title: 'Email',
              hintText: 'Cth: jagoan_olshop',
              controller: emailController,
              validator: (data) {
                if (data == null) {
                  return 'Email tidak boleh kosong!';
                } else {
                  return validationError;
                }
              },
            );
          },
        ),
      );
    }

    Widget inputPassword() {
      String? validationError;

      return MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              validationError = null;
              if (state is AuthFailed) {
                if (state.error['errors']['password'] != null) {
                  validationError = state.error['errors']['password'][0];
                }
              }
            },
          )
        ],
        child: BlocBuilder(
          bloc: authCubit,
          builder: (context, state) {
            return CustomFormField(
              title: 'Password',
              hintText: 'Masukkan Password',
              obsecureText: true,
              controller: passwordController,
              validator: (data) {
                if (data == null) {
                  return 'Password tidak boleh kosong!';
                } else {
                  return validationError;
                }
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 252,
            decoration: BoxDecoration(color: kPrimaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 114,
                  height: 49,
                  margin: const EdgeInsets.only(top: 40),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image_logo_wibinx.png'),
                    ),
                  ),
                ),
                Container(
                  width: 187,
                  height: 138,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image_login_ilustration.png'),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: 33, bottom: 40, left: defaultMargin, right: defaultMargin),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Masuk ke Akun Wibinx',
                    style: blackTextStyle.copyWith(
                        fontSize: 20, fontWeight: medium),
                  ),
                   const SizedBox(
                    height: 25,
                  ),
                  inputUsername(),
                  inputPassword(),
                  const SizedBox(
                    height: 42,
                  ),
                  BlocListener(
                    bloc: authCubit,
                    listener: (context, state) {
                      if(state is AuthSuccess) {
                        print(state.data['data']['account']['websites']);
                        Navigator.of(context).pushNamedAndRemoveUntil('/main-page', (Route<dynamic> route) => false);
                      }
                    },
                    child: BlocBuilder(
                      bloc: authCubit,
                      builder: (context, state) {
                        return CustomButton(
                          title: 'Masuk',
                          onPressed: () async {
                            authCubit.signIn(
                                emailController.text, passwordController.text);
                          },
                        );
                      },
                    ),
                  ),
                  Text(emailController.text),
                  const SizedBox(
                    height: 28,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum punya akun ?',
                        style: greyTextStyle.copyWith(fontWeight: medium),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register-page');
                          },
                          child: Text(
                            'Daftar',
                            style:
                                primaryTextStyle.copyWith(fontWeight: medium),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
