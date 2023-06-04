import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wibinx_app/blocs/cubit/page_cubit.dart';
import 'package:wibinx_app/shared/theme.dart';
import 'package:wibinx_app/ui/pages/home_page.dart';
import 'package:wibinx_app/ui/pages/profile_user_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageCubit pageCubit = context.read<PageCubit>();

    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return ProfileUserPage();
        default:
          return const HomePage();
      }
    }

    Widget navigationBar() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: kWhiteColor,
            border: Border(top: BorderSide(width: 1, color: kOutlineColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    pageCubit.setPage(0);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.home,
                        size: 35,
                      ),
                      Text(
                        'Home',
                        style: blackTextStyle.copyWith(
                            fontWeight: semibold, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    pageCubit.setPage(1);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person,
                        size: 35,
                      ),
                      Text(
                        'Akun',
                        style: blackTextStyle.copyWith(
                            fontWeight: semibold, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    pageCubit.setPage(0);

    return BlocBuilder<PageCubit, int>(
      bloc: pageCubit,
      builder: (context, currentIndex) {
        return Scaffold(
          body: Stack(
            children: [
              buildContent(currentIndex),
              navigationBar(),
            ],
          ),
        );
      },
    );
  }
}
