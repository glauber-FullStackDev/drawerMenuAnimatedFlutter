import 'package:animated_sidebar/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:animated_sidebar/pages/homepage.dart';
import 'package:animated_sidebar/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocProvider<NavigationBlock>(
        create: (context) => NavigationBlock(),
        child: Stack(children: [
          BlocBuilder<NavigationBlock, NavigationStates>(builder: (constext, navigatioState) {
            return navigatioState as Widget;
          },),
          SideBar()
        ],),
      ) 
    );
  }
}