import 'package:flutter/material.dart';

import '../../views/home_screen/homescreen.dart';
import '../../utilities/color_constant.dart';
import '../../utilities/image_constant.dart';

// ignore: must_be_immutable
class BottomBarNavigator extends StatefulWidget {
  const BottomBarNavigator({super.key});

  @override
  State<BottomBarNavigator> createState() => _BottomBarNavigatorState();
}

class _BottomBarNavigatorState extends State<BottomBarNavigator> {
  int selectedIndex = 0;
  bool isBottomNav = true;

  _BottomBarNavigatorState();

  Widget? pageCaller(index) {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SizedBox();
      case 2:
        return const SizedBox();
      case 3:
        return const SizedBox();

      default:
        return const SizedBox();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      body: pageCaller(selectedIndex),
      bottomNavigationBar: isBottomNav == true
          ? BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icHome),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icSearch),
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icHistory),
                  ),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icProfile),
                  ),
                  label: 'Profile',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: ColorConstant.primaryColor,
              selectedLabelStyle: TextStyle(
                color: ColorConstant.primaryColor,
              ),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(
                color: Colors.black,
              ),
              showUnselectedLabels: true,
              elevation: 0,
              onTap: _onItemTapped,
            )
          : Container(
              height: 0,
            ),
    );
  }
}
