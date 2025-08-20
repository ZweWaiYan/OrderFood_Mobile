import 'dart:async';

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
  int _selectedCategoryIndex = 0;
  final Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  // LocationData? _locationData;

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  final CollectionReference meals = FirebaseFirestore.instance.collection(
    'popular',
  );

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

    void showExitDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop(); // ✅ Close app
              },
              child: const Text('Exit'),
            ),
          ],
        ),
      );
    }

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

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          handleBackButton();
        }
      },
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              //User's Location
                              child: GestureDetector(
                                onTap: () {
                                  _requestLocationPermisison();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 3,
                                          bottom: 2.5,
                                        ),
                                        child: Text(
                                          'Magway...',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                /// Popular Items section that disappears cleanly
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child:
                      (_selectedCategoryIndex == -1 ||
                          _selectedCategoryIndex == 0)
                      ? Column(
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
                                    Container(
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    // Text overlay
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Popular Items",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // SizedBox(
                            //   height: 210,
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     padding: const EdgeInsets.symmetric(
                            //       horizontal: 8,
                            //     ),
                            //     itemCount: 10,
                            //     itemBuilder: (context, index) =>
                            //         GestureDetector(
                            //           onTap: () {
                            //             Navigator.pushReplacementNamed(
                            //               context,
                            //               '/detailPage',
                            //             );
                            //           },
                            //           child: const PopularCard(),
                            //         ),
                            //   ),
                            // ),
                            // Text(
                            //   _connectionStatus.toString(),
                            //   style: Theme.of(context).textTheme.headlineSmall,
                            // ),
                            SizedBox(
                              height: 210,
                              child:
                                  // _connectionStatus.toString() !=
                                  //     '[ConnectivityResult.none]'
                                  // ?
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('popular')
                                        .snapshots(
                                          // includeMetadataChanges: true,
                                        ),
                                    builder: (context, snapshot) {
                                      // final populars = snapshot.data!.docs;

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return _buildPopularShimmerList(); // show shimmer while loading
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.docs.isEmpty) {
                                        return const Center(
                                          child: Text("No popular items found"),
                                        );
                                      } else {
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            final popular =
                                                snapshot.data!.docs[index];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  '/detailPage',
                                                  arguments: popular,
                                                );
                                              },
                                              child: PopularCard(
                                                name: popular['name'],
                                                imageUrl: popular['imageUrl'],
                                                price: popular['price'],
                                                description:
                                                    popular['description'],
                                                isLoading: false,
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                              // : _buildPopularShimmerList(),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),

                /// Category selector + responsive layout
                AnimatedSlide(
                  offset: _selectedCategoryIndex != -1
                      ? const Offset(0, 0)
                      : const Offset(0, 0),
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryLists.length,
                          itemBuilder: (context, index) {
                            final isSelected = _selectedCategoryIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex =
                                      _selectedCategoryIndex == index
                                      ? -1
                                      : index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.orange
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 3,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    categoryLists[index],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5),

                      // const Padding(
                      //   padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                      //   child: ResponsiveLayout(),
                      // ),
                      // _connectionStatus.toString() !=
                      //         '[ConnectivityResult.none]'
                      //     ?
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('meals')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return _buildCategoryShimmerList();
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(child: Text('No data found'));
                          } else if (snapshot.hasData) {
                            final docs = snapshot.data!.docs;

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                15.0,
                                8.0,
                                15.0,
                                8.0,
                              ),
                              child: ResponsiveLayout(data: docs),
                            );
                          } else {
                            // Fallback return widget (should never happen, but avoids error)
                            return _buildCategoryShimmerList();
                          }
                        },
                      ),
                      // : _buildCategoryShimmerList(),
                    ],
                  ),
                ),
              ],
            ),
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
}
