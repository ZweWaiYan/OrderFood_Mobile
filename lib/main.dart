import 'package:deli_pos/cart_page.dart';
import 'package:deli_pos/component/successfulModal.dart';
import 'package:deli_pos/confirmOrder_page.dart';
import 'package:deli_pos/detail_page.dart';
import 'package:deli_pos/favourite_page.dart';
import 'package:deli_pos/history_page.dart';
import 'package:deli_pos/home_page.dart';
import 'package:deli_pos/login_page.dart';
import 'package:deli_pos/register_page.dart';
import 'package:deli_pos/track_page.dart';
import 'package:deli_pos/user_page.dart';
import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/loginPage',
      // initialRoute: '/confirmOrderPage',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 234, 197),
      ),
      routes: {
        '/': (context) => const MainScaffold(),
        '/detailPage': (context) => const DetailPage(),
        '/cartPage': (context) => const CartPage(),
        '/confirmOrderPage': (context) => const ConfirmorderPage(),
        '/trackPage': (context) => const TrackPage(),
        '/historyPage': (context) => const HistoryPage(),
        '/successfulModal': (context) => const SuccessfulModal(),
        '/favouritePage': (context) => const FavouritePage(),
        '/userPage': (context) => const UserPage(),
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const RegisterPage(),
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = const [
    HomePage(),
    CartPage(),
    HistoryPage(),
    FavouritePage(),
    UserPage(),
    TrackPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: 58,
        items: List.generate(5, (index) {
          final bool isSelected = _page == index;

          final iconList = [
            Icons.home_outlined,
            Icons.shopping_cart_outlined,
            Icons.history_toggle_off_sharp,
            Icons.favorite_border,
            Icons.person_outline,
          ];

          return Icon(
            iconList[index],
            size: 23,
            color: isSelected ? Colors.white : Colors.black,
          );
        }),
        color: Colors.white,
        buttonBackgroundColor: const Color.fromARGB(255, 255, 128, 0),
        backgroundColor: const Color.fromARGB(255, 255, 234, 197),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _pages[_page],
    );
  }
}
