import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wibinx_app/blocs/cubit/link_user_cubit.dart';
import 'package:wibinx_app/blocs/cubit/product_cubit.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_button_delete_secondary.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field_upload.dart';

class FormProductPage extends StatelessWidget {
  final String title, icon;
  final Map<String, dynamic>? data;
  final int section_id;

  const FormProductPage({
    Key? key,
    required this.title,
    required this.icon,
    this.data = null,
    required this.section_id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductCubit productCubit = ProductCubit();

    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController hargaController = TextEditingController();
    TextEditingController linkProductController = TextEditingController();
    TextEditingController linkController = TextEditingController();

    XFile? logo;

    nameController.text = data?['name'] ?? '';
    descriptionController.text = data?['description'] ?? '';
    hargaController.text = data?['harga'].toString() ?? '';
    linkProductController.text = data?['link_product'] ?? '';
    linkController.text = data?['url'] ?? '';

    Widget inputNameProduct() {
      return CustomFormField(
        title: 'Nama',
        hintText: 'Masukkan Nama Produk..',
        validator: (data) => null,
        controller: nameController,
      );
    }

    Widget inputDescriptionProduct() {
      return CustomFormField(
        title: 'Description',
        hintText: 'Masukkan Deskripsi Produk..',
        validator: (data) => null,
        maxLines: 3,
        controller: descriptionController,
      );
    }

    Widget inputHargaProduct() {
      return CustomFormField(
        title: 'Harga',
        hintText: 'Masukkan Harga Produk..',
        validator: (data) => null,
        controller: hargaController,
        keyboardType: 'number',
      );
    }

    Widget inputLinkProduct() {
      return CustomFormField(
        title: 'Link Produk',
        hintText: 'Masukkan Link Produk..',
        validator: (data) => null,
        controller: linkProductController,
      );
    }

    Widget inputUploadProduct() {
      return CustomFormFieldUpload(
        title: 'Foto Produk',
        onUploaded: (image) {
          logo = image;
        },
        imageUrl: data?['product_image']?['original_url'],
      );
    }

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
                inputNameProduct(),
                inputDescriptionProduct(),
                inputHargaProduct(),
                inputLinkProduct(),
                inputUploadProduct(),
                SizedBox(
                  height: 250,
                )
              ],
            ),
            BlocListener(
              bloc: productCubit,
              listener: (context, state) {
                if (state is ProductSuccess) {
                  Navigator.pop(context, 'back');
                }

                if(state is ProductDeleted) {
                  Navigator.pop(context, 'back');
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    title: 'Simpan',
                    onPressed: () {
                      if (data?['id'] != null) {
                        productCubit.update({
                          'id': data?['id'],
                          'name': nameController.text,
                          'description': descriptionController.text,
                          'harga': hargaController.text,
                          'section_id': section_id,
                          'link_product': linkProductController.text,
                          'image': logo,
                        });
                      } else {
                        productCubit.store({
                          'name': nameController.text,
                          'description': descriptionController.text,
                          'harga': hargaController.text,
                          'section_id': section_id,
                          'link_product': linkProductController.text,
                          'image': logo,
                        });
                      }
                    },
                    margin: EdgeInsets.only(bottom: 25),
                  ),
                  data?['id'] != null
                      ? CustomButtonDeleteSecondary(
                          title: 'Hapus Produk',
                          onPressed: () {
                            showMyDialog(context, Text('Pemberitahuan'), [
                              Text('Apakah anda yakin ingin menghapus produk'),
                            ], [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: Text('Batal')),
                              TextButton(
                                onPressed: () {
                                  productCubit.delete(data?['id']);
                                  Navigator.pop(context, 'backDialog');
                                },
                                child: Text(
                                  'Hapus',
                                  style: dangerTextStyle,
                                ),
                              ),
                            ]);
                          },
                          margin: EdgeInsets.only(bottom: 25),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
