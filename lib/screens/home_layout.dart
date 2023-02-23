import 'package:amlelshefaa/core/utils/size_config.dart';

import '../bloc/cubit/app_cubit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            index: cubit.curIndex,
            height: 60.0,
            items: const <Widget>[
              Icon(Icons.home_outlined, size: 30, color: Colors.white),
              Icon(Icons.perm_identity, size: 30, color: Colors.white),
            ],
            color: Colors.orangeAccent,
            // buttonBackgroundColor: Colors.black,
            backgroundColor: const Color(0xFFF5F1D7),
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              cubit.changeIndex(index);
            },
            letIndexChange: (index) => true,
          ),
          body: cubit.screenWidget[cubit.curIndex]);
    });
  }
}
