import 'package:deli_pos/component/allShopCard.dart';
import 'package:flutter/material.dart';

class NearestPage extends StatefulWidget {
  const NearestPage({super.key});

  @override
  State<NearestPage> createState() => _NearestPageState();
}

class _NearestPageState extends State<NearestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
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
                    'Nearest Page',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // All Restaurants button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: 0.6,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  15,
                                  12,
                                  15,
                                  0,
                                ),
                                child: Text(
                                  "All Restaurants",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Search box overlapping
                        Positioned(
                          left:
                              MediaQuery.of(context).size.width *
                              0.35, // 35% from left
                          right: 0,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const TextField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search, size: 18),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 0,
                                ),
                                border: InputBorder.none,
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

              // List of Restaurants
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Allshopcard(
                    name: "ARabian Restaurant",
                    description: "Loream Isofg fjref erew",
                    imageUrl:
                        "https://cdn.shopify.com/s/files/1/0491/2165/6981/files/Eco-Friendly_and_Sustainable_480x480.webp?v=1733402305",
                    avatarUrl: "https://i.pravatar.cc/100",
                    rating: 4.9,
                    time: "30 min",
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
