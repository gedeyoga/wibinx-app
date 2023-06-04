import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/custom_button.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field.dart';
import 'package:wibinx_app/ui/widgets/custom_form_field_group.dart';

class FormLinkPage extends StatelessWidget {
  final String title, icon;

  const FormLinkPage({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
          children: [
            ListView(
              children: [
                CustomFormField(
                    title: 'Nama', hintText: 'Masukkan Nama Link..' , validator: (data) => null,
                ),
                CustomFormFieldGroup(
                  title: 'Link ' + title,
                  hintText: 'Masukan link...',
                  icon: icon,
                  validator: (data) => null,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                title: 'Simpan',
                onPressed: () {},
                margin: EdgeInsets.only(bottom: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
