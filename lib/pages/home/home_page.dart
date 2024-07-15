import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/pages/account/account_page.dart';
import 'package:test/pages/cart/cart_history.dart';
//import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:test/pages/home/main_food_page.dart';
import 'package:test/pages/reservation/reser_page.dart';
import 'package:test/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;

  
  List pages=[
    MainFoodPage(),
    ResarvationPage(),
    CartHistory(),
    AccountPage(),
  ];

  void onTapNav(int index){
    setState(() {
      _selectedIndex=index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label:"home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_restaurant_outlined),
            label: "histor",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "me",
          ),
        ],
      ),
    );
  }


}