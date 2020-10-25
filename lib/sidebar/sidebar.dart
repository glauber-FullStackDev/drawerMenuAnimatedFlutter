import 'dart:async';

import 'package:animated_sidebar/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:animated_sidebar/sidebar/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSidebarOpenedStreamController.stream;
    isSideBarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSideBarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWith = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context, isSidebarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSidebarOpenedAsync.data ? 0 : -screenWith,
          right: isSidebarOpenedAsync.data ? 0 : screenWith - 45,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFF262AAA),
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      ListTile(
                        title: Text("Glauber de Souza",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800)),
                        subtitle: Text("glauber.fullstackdev@gmail.com",
                            style: TextStyle(
                                color: Color(0xFF1BB5FD), fontSize: 12)),
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF262AAA),
                          child: Image(image: AssetImage('./assets/logo.png'),),
                          // Icon(
                            // Icons.perm_identity,
                            // color: Colors.white,
                          // ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.6),
                        indent: 16,
                        endIndent: 16,
                      ),
                      MenuItem(icon: Icons.home, title: "Home", onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBlock>(context).add(NavigationEvents.HomePageClickedEvent);
                      },),
                      MenuItem(icon: Icons.person, title: "My Account", onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBlock>(context).add(NavigationEvents.MyAccountClickedEvent);
                      },),
                      MenuItem(icon: Icons.shopping_basket, title: "My Orders", onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBlock>(context).add(NavigationEvents.MyOrdersClickedEvent);
                      },),
                      MenuItem(icon: Icons.card_giftcard, title: "Wishlist"),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.6),
                        indent: 16,
                        endIndent: 16,
                      ),
                      MenuItem(icon: Icons.settings, title: "Settings"),
                      MenuItem(icon: Icons.exit_to_app, title: "logout"),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
