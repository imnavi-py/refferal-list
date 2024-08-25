import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:moaarefyar/screens/home_screen.dart';
import 'package:moaarefyar/screens/info_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentindex = 0;
  Widget body = HomeScreen();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          // inactiveColor: Colors.black54,
          inactiveColor: const Color.fromARGB(255, 165, 190, 207),
          activeColor: const Color.fromARGB(255, 51, 84, 149),
          icons: const [Icons.home, Icons.money_sharp],
          activeIndex: currentindex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          onTap: (index) {
            if (index == 0) {
              body = HomeScreen();
            } else {
              body = InfoScreen();
            }
            setState(() {
              currentindex = index;
            });
          },
        ),
        body: body,
      ),
    );
  }
}
