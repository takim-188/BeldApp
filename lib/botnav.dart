import 'package:beldapp/help.dart';
import 'package:beldapp/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'bildiri_page.dart';
import 'home_page.dart';
import 'leaderboard_page.dart';


class UserSignInBotNav extends StatefulWidget {
  const UserSignInBotNav({Key? key}) : super(key: key);

  @override
  State<UserSignInBotNav> createState() => _UserSignInBotNavState();
}

class _UserSignInBotNavState extends State<UserSignInBotNav> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final items = <Widget> [
    Icon(Icons.leaderboard_outlined, size: 30,),
    Icon(Icons.help, size: 30),
    Icon(Icons.home, size: 30,),
    Icon(Icons.announcement_outlined, size: 30,),
    Icon(Icons.person, size:30)




  ];
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  final screens = [
    ProfileList(),
    HelpPage(),
    HomePage(),
    BildiriPage(),
    ProfilePage()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color:Colors.white)
        ),
        child: CurvedNavigationBar(
          key: navigationKey,
          color: Color(0xff22e3d7),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Color(0xfff20c60),
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          index: index,
          items: items,
          onTap: (index) => setState(() => this.index = index) ,

        ),
      ),
    );
  }
}