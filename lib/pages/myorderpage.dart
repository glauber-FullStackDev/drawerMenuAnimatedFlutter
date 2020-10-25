import 'package:animated_sidebar/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

class MyOrderPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("MyOrderPage", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28)),
    );
  }
}