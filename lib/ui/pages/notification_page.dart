import 'package:flutter/material.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/widgets/card_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
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
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            CardWidget(
              title: 'Perpanjangan Paket Pelanggan',
              description: 'Halo yoga masa berlaku paket kamu sudah habis ',
              icon: 'assets/icon_marketplace.png',
              onTap: () {},
              status: 'unread',
            ),
            CardWidget(
              title: 'Perpanjangan Paket Pelanggan',
              description: 'Halo yoga masa berlaku paket kamu sudah habis ',
              icon: 'assets/icon_marketplace.png',
              onTap: () {},
              status: 'readed',
            ),
            CardWidget(
              title: 'Perpanjangan Paket Pelanggan',
              description: 'Halo yoga masa berlaku paket kamu sudah habis ',
              icon: 'assets/icon_marketplace.png',
              onTap: () {},
              status: 'readed',
            ),
            CardWidget(
              title: 'Perpanjangan Paket Pelanggan',
              description: 'Halo yoga masa berlaku paket kamu sudah habis ',
              icon: 'assets/icon_marketplace.png',
              onTap: () {},
              status: 'readed',
            ),
            CardWidget(
              title: 'Perpanjangan Paket Pelanggan',
              description: 'Halo yoga masa berlaku paket kamu sudah habis ',
              icon: 'assets/icon_marketplace.png',
              onTap: () {},
              status: 'unread',
            ),
            CardWidget(
              title: 'Perpanjangan Paket Pelanggan',
              description: 'Halo yoga masa berlaku paket kamu sudah habis ',
              icon: 'assets/icon_marketplace.png',
              onTap: () {},
              status: 'unread',
            ),
            CardWidget(
              title: 'Perpanjangan Paket Pelanggan',
              description: 'Halo yoga masa berlaku paket kamu sudah habis ',
              icon: 'assets/icon_marketplace.png',
              onTap: () {},
              status: 'readed',
            ),
            CardWidget(
              title: 'Perpanjangan Paket Pelanggan',
              description: 'Halo yoga masa berlaku paket kamu sudah habis ',
              icon: 'assets/icon_marketplace.png',
              onTap: () {},
              status: 'readed',
            ),
            CardWidget(
              title: 'Perpanjangan Paket Pelanggan',
              description: 'Halo yoga masa berlaku paket kamu sudah habis ',
              icon: 'assets/icon_marketplace.png',
              onTap: () {},
              status: 'readed',
            ),
            CardWidget(
              title: 'Perpanjangan Paket Pelanggan',
              description: 'Halo yoga masa berlaku paket kamu sudah habis ',
              icon: 'assets/icon_marketplace.png',
              onTap: () {},
              status: 'unread',
            ),
            CardWidget(
              title: 'Perpanjangan Paket Pelanggan',
              description: 'Halo yoga masa berlaku paket kamu sudah habis ',
              icon: 'assets/icon_marketplace.png',
              onTap: () {},
              status: 'unread',
            ),
          ],
        ),
      ),
    );
  }
}
