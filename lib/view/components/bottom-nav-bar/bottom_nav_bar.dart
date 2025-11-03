import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/util.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/games/games_screen.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/home/home_screen.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/menu/menu_screen.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/wallet/wallet_screen.dart';
import 'package:get/get.dart';
import 'nav_bar_item_widget.dart';

/// A widget that displays the bottom navigation bar.
class BottomNavBar extends StatefulWidget {
  /// Creates a new [BottomNavBar] instance.
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  /// The list of screens to display in the bottom navigation bar.
  List<Widget> screens = [
    const HomeScreen(),
    const GamesScreen(),
    const WalletScreen(),
    const MenuScreen(),
  ];

  /// The index of the currently selected screen.
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bottomColor,
      body: screens[currentIndex],
      bottomNavigationBar: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MyColor.bottomColor,
            border: Border(
              top: BorderSide(
                color: MyColor.borderColor.withOpacity(.7),
                width: .5,
              ),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: MyUtils.getCardShadow(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavBarItem(
                label: MyStrings.lobby.tr.toUpperCase(),
                imagePath: MyImages.lobby,
                index: 0,
                isSelected: currentIndex == 0,
                press: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
              ),
              NavBarItem(
                label: MyStrings.games.tr.toUpperCase(),
                imagePath: MyImages.games,
                index: 1,
                isSelected: currentIndex == 1,
                press: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
              ),
              NavBarItem(
                label: MyStrings.wallet.tr.toUpperCase(),
                imagePath: MyImages.wallet,
                index: 2,
                isSelected: currentIndex == 2,
                press: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
              ),
              NavBarItem(
                label: MyStrings.profile.tr.toUpperCase(),
                imagePath: MyImages.navProfile,
                index: 3,
                isSelected: currentIndex == 3,
                press: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
