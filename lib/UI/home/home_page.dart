import 'dart:async';

import 'package:deli_pos/filterData/local_data.dart';
import 'package:flutter/material.dart';
import 'package:deli_pos/component/popularCard.dart';
import 'package:deli_pos/layouts/responsiveLayout.dart';
import 'package:deli_pos/filterData/filter_data.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<HomePage> {
  DateTime? lastBackPressed;

  int _selectedCategoryIndex = 0;
  final Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  // LocationData? _locationData;

  int _selectedIndex = 0;
  final List<String> _tabs = ["All", "Nearest", "New Shop"];

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Future<void> handleBackButton() async {
    final now = DateTime.now();
    if (lastBackPressed == null ||
        now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
      lastBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      showExitDialog();
    }
  }

  Future<bool> onWillPop() async {
    await handleBackButton();
    // Returning false prevents automatic pop
    return false;
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      // developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  void _requestLocationPermisison() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        return;
      }
    }

    //location service is enabled and permission granted
    // _locationData = await location.getLocation();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    DateTime? lastBackPressed;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 4,
            backgroundColor: Colors.black,
            flexibleSpace: Container(
              color: const Color.fromARGB(255, 255, 234, 197),
              padding: const EdgeInsets.fromLTRB(25, 35, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      25,
                                    ), // half of width/height for circle
                                    child: Image.asset(
                                      'assets/user.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  "Sakura",
                                  style: GoogleFonts.lobster(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                // Column(
                                //   children: [
                                //     Text(
                                //         "Latitude: ${_locationData?.latitude ?? ""}"),
                                //     Text(
                                //         "Longitude: ${_locationData?.longitude ?? ""}"),
                                //   ],
                                // ),
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
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Choose",
                              style: GoogleFonts.lobster(
                                textStyle: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "your favorite ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 142, 142, 142),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "food!",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(
                                        255,
                                        255,
                                        161,
                                        20,
                                      ), // or Colors.yellow
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const SizedBox(
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search, size: 18),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 16,
                          ),
                          border: InputBorder.none, // Removes the black border
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            /// Card (scrolls away)
            SliverToBoxAdapter(
              child:
                  /// Popular Items
                  Column(
                    key: const ValueKey("popular"),
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                'assets/homePromoImg.jpg',
                                fit: BoxFit.cover,
                              ),
                              // Semi-transparent black layer (optional for readability)
                              Container(color: Colors.black.withOpacity(0.3)),
                              // Text overlay
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Free Combo',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                    Text(
                                      'Burger + Coca-Cola',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                    Text(
                                      'for new user',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            ),

            /// Sticky Tabs
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
                  child: Row(
                    children: List.generate(_tabs.length, (index) {
                      final isSelected = _selectedIndex == index;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ChoiceChip(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _tabs[index],
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.orange,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            selected: isSelected,
                            showCheckmark: false,
                            selectedColor: Colors.orange,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.orange),
                            ),
                            onSelected: (_) {
                              setState(() {
                                _selectedIndex = index;
                              });

                              switch (index) {
                                case 0:
                                  Navigator.pushNamed(context, "/allPage");
                                  break;
                                case 1:
                                  Navigator.pushNamed(context, "/nearestPage");
                                  break;
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],

          body: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                child: Text(
                  "Popular Items",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              //with Online Db
              // SizedBox(
              //   height: 210,
              //   child: StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('popular')
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return _buildPopularShimmerList(); // show shimmer while loading
              //       } else if (!snapshot.hasData ||
              //           snapshot.data!.docs.isEmpty) {
              //         return const Center(
              //           child: Text("No popular items found"),
              //         );
              //       } else {
              //         return ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           padding: const EdgeInsets.symmetric(horizontal: 8),
              //           itemCount: snapshot.data!.docs.length,
              //           itemBuilder: (context, index) {
              //             final popular = snapshot.data!.docs[index];
              //             return GestureDetector(
              //               onTap: () {
              //                 Navigator.pushReplacementNamed(
              //                   context,
              //                   '/detailPage',
              //                   arguments: popular,
              //                 );
              //               },
              //               child: PopularCard(
              //                 name: popular['name'],
              //                 imageUrl: popular['imageUrl'],
              //                 price: popular['price'],
              //                 description: popular['description'],
              //                 isLoading: false,
              //               ),
              //             );
              //           },
              //         );
              //       }
              //     },
              //   ),
              // ),
              //Local DB
              SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: popular.length,
                  itemBuilder: (context, index) {
                    final item = popular[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/detailPage',
                          arguments: item,
                        );
                      },
                      child: PopularCard(
                        name: item['name'],
                        imageUrl: item['imageUrl'],
                        price: item['price'],
                        description: item['description'],
                        isLoading: false,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 5),

              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "Season Foods",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              //Online DB
              // SizedBox(
              //   height: 210,
              //   child: StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('popular')
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return _buildPopularShimmerList(); // show shimmer while loading
              //       } else if (!snapshot.hasData ||
              //           snapshot.data!.docs.isEmpty) {
              //         return const Center(
              //           child: Text("No popular items found"),
              //         );
              //       } else {
              //         return ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           padding: const EdgeInsets.symmetric(horizontal: 8),
              //           itemCount: snapshot.data!.docs.length,
              //           itemBuilder: (context, index) {
              //             final popular = snapshot.data!.docs[index];
              //             return GestureDetector(
              //               onTap: () {
              //                 Navigator.pushReplacementNamed(
              //                   context,
              //                   '/detailPage',
              //                   arguments: popular,
              //                 );
              //               },
              //               child: PopularCard(
              //                 name: popular['name'],
              //                 imageUrl: popular['imageUrl'],
              //                 price: popular['price'],
              //                 description: popular['description'],
              //                 isLoading: false,
              //               ),
              //             );
              //           },
              //         );
              //       }
              //     },
              //   ),
              //   // : _buildPopularShimmerList(),
              // ),
              //Local DB
              SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    final item = meals[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/detailPage',
                          arguments: item,
                        );
                      },
                      child: PopularCard(
                        name: item['name'],
                        imageUrl: item['imageUrl'],
                        price: item['price'],
                        description: item['description'],
                        isLoading: false,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularShimmerList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: 5, // shimmer placeholder count
      itemBuilder: (context, index) {
        return PopularCard(
          name: "",
          imageUrl: "",
          price: "",
          description: "",
          isLoading: true, // shimmer mode
        );
      },
    );
  }

  Widget _buildCategoryShimmerList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2, // 2 columns
        itemCount: 8, // 8 items
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Title placeholder
                  Container(
                    height: 14,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 6),
                  // Description placeholder
                  Container(height: 12, width: 120, color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  // Bottom row placeholder
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(height: 12, width: 40, color: Colors.grey[300]),
                      Container(height: 12, width: 40, color: Colors.grey[300]),
                      Container(height: 18, width: 18, color: Colors.grey[300]),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) =>
            const StaggeredTile.fit(1), // each tile = 1 column
      ),
    );
  }

  void showExitDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you really want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _TabBarDelegate(this.child);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Color.fromARGB(255, 255, 234, 197), // optional background
      child: child,
    );
  }

  @override
  double get maxExtent => 55; // Adjust height to fit your ChoiceChips
  @override
  double get minExtent => 55;

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
