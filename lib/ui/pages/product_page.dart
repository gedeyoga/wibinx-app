import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/pages/form_link_page.dart';
import 'package:wibinx_app/ui/pages/form_product_page.dart';
import 'package:wibinx_app/ui/widgets/card_product_widget.dart';
import 'package:wibinx_app/ui/widgets/card_widget.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wibinx_app/blocs/cubit/auth_cubit.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = const FlutterSecureStorage();
    AuthCubit authCubit = context.read<AuthCubit>();
    int section_id = 0;


    fetchAuthProfile() async {
      var userId = await storage.read(key: 'userId');

      authCubit.authProfile(int.parse(userId.toString()));
    }

    List<Widget> generateList(List products) {
      List<Widget> widgets = [];

      products.forEach((element) {
        widgets.add(CardProductWidget(
          title: element['name'] ?? '',
          price: element['harga'] ?? 0,
          imageUrl: element['product_image']?['original_url'],
          // imageUrl: '',
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormProductPage(
                  title: 'Edit Produk',
                  icon: 'assets/icon_profile_website.png',
                  section_id: section_id,
                  data: element,
                ),
              ),
            );

            fetchAuthProfile();
          },
        ));
      });
      

      return widgets;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produk',
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
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: FutureBuilder(
            future: fetchAuthProfile(),
            builder: (context, snapshot) {
              return Stack(
                children: [
                  BlocBuilder(
                    bloc: authCubit,
                    builder: (context, state) {

                      if (state is AuthProfile) {

                        var sections = state.user.websites?[0]['sections'] as List ;

                        var section = sections.firstWhere((section) => section['slug'] == 'product');
                        section_id = section['id'];

                        List products = section['products'];

                        if (products.length > 0) {
                          return ListView(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              ...generateList(products),
                              SizedBox(height: 120),
                            ],
                          );
                        }
                      }
                      return Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: kGreyColor, width: 1),
                        ),
                        child: Center(child: Text('Tidak ada data')),
                      );
                    },
                  ),
                  BlocBuilder(
                    bloc: authCubit,
                    builder: (context, state) {
                      int section_id = 0;
                      if (state is AuthProfile) {
                        var sections = state.user.websites?[0]['sections'] as List ;

                        var section = sections.firstWhere((section) => section['slug'] == 'product');
                        section_id = section['id'];
                      }

                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(color: kWhiteColor),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: CustomButton(
                            title: 'Tambah Produk',
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormProductPage(
                                    title: 'Tambah Produk',
                                    icon: 'assets/icon_profile_website.png',
                                    section_id: section_id,
                                  ),
                                ),
                              );

                              fetchAuthProfile();
                            },
                          ),
                        ),
                      );
                    },
                  )
                ],
              );
            },
          )),
    );
  }
}
