import 'package:deli_pos/filterData/filter_data.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedLanguage = 'English';

  bool notification = false;
  bool promotionNotification = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushReplacementNamed(context, '/');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              //Header
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_circle_left_rounded,
                            color: Color(0xFFFF8C00),
                            size: 30,
                          ),
                          onPressed: () =>
                              Navigator.pushReplacementNamed(context, '/'),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.dark_mode_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              //body
              Expanded(
                child: SingleChildScrollView(
                  child: //Body
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      35,
                                    ), // half of width/height for circle
                                    child: Image.asset(
                                      'assets/user.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mew Hnin Wai",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFFFE8C00),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone_outlined,
                                          size: 18,
                                          color: Color(0xFF878787),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "(+95) 9 767878906",
                                          style: TextStyle(
                                            color: Color(0xFF878787),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          size: 18,
                                          color: Color(0xFF878787),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "example@gmail.com",
                                          style: TextStyle(
                                            color: Color(0xFF878787),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/editprofilePage',
                                );
                              },
                              icon: Icon(
                                Icons.edit_outlined,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        //General Tabs
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 3),
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 25.0),
                                      child: Text(
                                        "General",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                                child: Divider(),
                              ),

                              //My Order
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.shopping_bag_outlined,
                                            size: 20,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "My Order",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10.0,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/myOrderPage',
                                          );
                                        },

                                        icon: const Icon(
                                          size: 18,
                                          Icons.arrow_forward_ios_rounded,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //My Location
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "My Location",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/myLocationPage',
                                          arguments: {
                                            'fromWhere': '/profilePage',
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        size: 18,
                                        Icons.arrow_forward_ios_rounded,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //My Location List
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "My Location List",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/myLocationlistPage',
                                          arguments: {
                                            'fromWhere': '/profilePage',
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        size: 18,
                                        Icons.arrow_forward_ios_rounded,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //Payment Methods
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.account_balance_wallet_outlined,
                                          size: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Payment Methods",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        size: 18,
                                        Icons.arrow_forward_ios_rounded,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //Invite Friends
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.people_outline_outlined,
                                          size: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Invite Friends",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/inviteFriendPage',
                                        );
                                      },
                                      icon: const Icon(
                                        size: 18,
                                        Icons.arrow_forward_ios_rounded,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //Security
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.security_outlined, size: 20),
                                        SizedBox(width: 10),
                                        Text(
                                          "Security",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/securityPage',
                                        );
                                      },
                                      icon: const Icon(
                                        size: 18,
                                        Icons.arrow_forward_ios_rounded,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //Languages
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 9,
                                  bottom: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.language_outlined,
                                            size: 20,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Language",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 20.0,
                                      ),
                                      padding: const EdgeInsets.only(left: 10),
                                      height:
                                          35, // increased height for better touch area
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Color.fromARGB(
                                            255,
                                            104,
                                            96,
                                            96,
                                          ),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: selectedLanguage,
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Roboto',
                                            color: Colors.black,
                                          ),
                                          items: languageTypes.map((
                                            String value,
                                          ) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            if (newValue == null) return;
                                            setState(() {
                                              selectedLanguage = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        //Notifications Tabs
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 3),
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 25.0),
                                      child: Text(
                                        "Notifications",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                                child: Divider(),
                              ),

                              //Notifications
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.notifications_none_rounded,
                                            size: 20,
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Notifications",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Inter',
                                                ),
                                              ),
                                              Text(
                                                "You will receive daily updates",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 20.0,
                                      ),
                                      child: Switch(
                                        value: notification,
                                        activeColor: Color(
                                          0xFFFE8C00,
                                        ), // custom active color
                                        onChanged: (bool value) {
                                          setState(() {
                                            notification = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Promotional Notifications
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      left: 20.0,
                                      top: 20,
                                      bottom: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.notifications_none_rounded,
                                          size: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Promotional Notifications",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                            Text(
                                              "You will receive daily updates",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Switch(
                                      value: promotionNotification,
                                      activeColor: Color(
                                        0xFFFE8C00,
                                      ), // custom active color
                                      onChanged: (bool value) {
                                        setState(() {
                                          promotionNotification = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        //More Tab
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 3),
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 25.0),
                                      child: Text(
                                        "More",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                                child: Divider(),
                              ),

                              //Team of Services
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      "Team of Services",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          '/termServicesPage',
                                        );
                                      },
                                      icon: const Icon(
                                        size: 18,
                                        Icons.arrow_forward_ios_rounded,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //Privacy Policy
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      "Privacy Policy",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          '/privacyPolicyPage',
                                        );
                                      },
                                      icon: const Icon(
                                        size: 18,
                                        Icons.arrow_forward_ios_rounded,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //About App
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        "About App",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10.0,
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          size: 18,
                                          Icons.arrow_forward_ios_rounded,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
