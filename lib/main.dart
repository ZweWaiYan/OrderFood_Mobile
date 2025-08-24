import 'package:deli_pos/UI/cart/cart_page.dart';
import 'package:deli_pos/UI/profile/editProfile_page.dart';
import 'package:deli_pos/UI/profile/inviteFriend_page.dart';
import 'package:deli_pos/UI/profile/myLocationList_page.dart';
import 'package:deli_pos/UI/profile/myLocation_page.dart';
import 'package:deli_pos/UI/profile/myOrder_page.dart';
import 'package:deli_pos/UI/profile/privacyPolicy_page.dart';
import 'package:deli_pos/UI/profile/termServices_page.dart';
import 'package:deli_pos/UI/security/forgetPassword_page.dart';
import 'package:deli_pos/UI/security/security_page.dart';
import 'package:deli_pos/UI/security/setNewPassword_page.dart';
import 'package:deli_pos/component/successfulModal.dart';
import 'package:deli_pos/UI/cart/confirmOrder_page.dart';
import 'package:deli_pos/UI/home/detail_page.dart';
import 'package:deli_pos/UI/favourite/favourite_page.dart';
import 'package:deli_pos/fileUpload_page.dart';
import 'package:deli_pos/UI/notification/notifcation_Page.dart';
import 'package:deli_pos/UI/home/home_page.dart';
import 'package:deli_pos/UI/auth/login_page.dart';
import 'package:deli_pos/UI/auth/register_page.dart';
import 'package:deli_pos/UI/cart/track_page.dart';
import 'package:deli_pos/UI/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/loginPage',
      // initialRoute: '/favouritePage',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 234, 197),
      ),
      routes: {
        '/': (context) => const MainScaffold(),
        '/detailPage': (context) => const DetailPage(),

        '/cartPage': (context) => const CartPage(),
        '/confirmOrderPage': (context) => const ConfirmorderPage(),
        '/successfulModal': (context) => const SuccessfulModal(),
        '/trackPage': (context) => const TrackPage(),

        '/notifcationPage': (context) => const NotifcationPage(),

        '/favouritePage': (context) => const FavouritePage(),

        '/profilePage': (context) => const ProfilePage(),
        '/editprofilePage': (context) => const EditprofilePage(),
        '/myOrderPage': (context) => const MyorderPage(),
        '/myLocationPage': (context) => const MylocationPage(),
        '/myLocationlistPage': (context) => const MylocationlistPage(),
        '/termServicesPage': (context) => const TermServicesPage(),
        '/privacyPolicyPage': (context) => const PrivacypolicyPage(),
        '/inviteFriendPage': (context) => const InvitefriendPage(),

        '/securityPage': (context) => const SecurityPage(),
        '/forgetpasswordPage': (context) => const ForgetpasswordPage(),
        '/mainNewPasswordPage': (context) => const SetnewpasswordPage(),

        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const RegisterPage(),

        '/fileuploadPage': (context) => const FileuploadPage(),
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
    NotifcationPage(),
    FavouritePage(),
    ProfilePage(),
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
            Icons.notifications_none,
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
