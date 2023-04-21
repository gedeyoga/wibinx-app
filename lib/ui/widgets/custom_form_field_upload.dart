import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wibinx_app/shared/theme.dart';

class CustomFormFieldUpload extends StatefulWidget {
  final String title;
  final int maxLines;

  const CustomFormFieldUpload({
    Key? key,
    required this.title,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<CustomFormFieldUpload> createState() => _CustomFormFieldUploadState();
}

class _CustomFormFieldUploadState extends State<CustomFormFieldUpload> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    Widget viewImage() {
      if (image != null) {
        return Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.file(File(image!.path)).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 120,
              child: Text(File(image!.path).path.split('/').last,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        );
      }
      return Text('Tidak ada foto ');
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: blackTextStyle,
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            width: double.infinity,
            height: 74,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: kGreyColor),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                viewImage(),
                Container(
                  width: 82,
                  height: 34,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: kOutlineColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: Text(
                      'Upload',
                      style: blackTextStyle.copyWith(fontWeight: medium),
                    ),
                    onPressed: () {
                      // Navigator.push(context);
                      getImage(ImageSource.gallery);
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
