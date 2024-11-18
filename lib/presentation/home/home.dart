import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:nhss_reign_forest_cafe/presentation/order/order_login.dart';
import 'package:nhss_reign_forest_cafe/presentation/redirects.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);

  void onTapTapped(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.ease);
    setState(() {
      _currentIndex = index;
    });
  }

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
      // borderRadius: BorderRadius.all(Radius.circular(25)),
      );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;

  EdgeInsets padding = Platform.isIOS
      ? const EdgeInsets.only(left: 10, right: 10)
      : const EdgeInsets.only(left: 10, right: 10);

  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Color(0xff9747FF);
  Color unselectedColor = Color(0xff060D14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: [
          StoreRedirect(),
          // Notifications(),
          //PreviousOrders(),
          OrderLogin(),
        ],
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor:
            Color.fromARGB(255, 0, 0, 0), // Color.fromARGB(255, 139, 205, 141),
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        // padding: padding,
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        currentIndex: _currentIndex,
        onTap: (index) async {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 30,
                color: Colors.white,
              ),
              label: 'store'),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.notifications_active_outlined,
          //       size: 30,
          //       color: Colors.white,
          //     ),
          //     label: "notifications"),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.description_outlined,
          //       size: 30,
          //       color: Colors.white,
          //     ),
          //     label: 'previous_orders'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 30,
                color: Colors.white,
              ),
              label: 'profile'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 25),
        unselectedLabelStyle: const TextStyle(fontSize: 25),
      ),
    );
  }
}
