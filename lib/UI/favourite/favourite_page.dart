import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deli_pos/layouts/responsiveLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    bool _myBackInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
      // This handles:
      // ✅ Android system back
      // ✅ Android predictive back (swipe)
      // ✅ iOS swipe back
      Navigator.pushReplacementNamed(context, '/homepage');
      return true; // stop default behavior
    }

    @override
    void initState() {
      super.initState();
      BackButtonInterceptor.add(_myBackInterceptor);
    }

    @override
    void dispose() {
      BackButtonInterceptor.remove(_myBackInterceptor);
      super.dispose();
    }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Row(
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
                      'Favourites',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Search
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 10),
                child: Container(
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
                    height: 44,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, size: 18),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      style: TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ),
                ),
              ),

              // Subtitle text
              const Padding(
                padding: EdgeInsets.fromLTRB(18.0, 1, 0, 10),
                child: Text(
                  'It`s time to buy your favorite Food.',
                  style: TextStyle(
                    color: Color.fromARGB(255, 250, 135, 2),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),

              // 🔑 Expanded makes only this part scroll
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('meals')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildCategoryShimmerList();
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No data found'));
                    }

                    final docs = snapshot.data!.docs;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 8.0,
                      ),
                      child: ResponsiveLayout(data: docs, isHomePage: false),
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
