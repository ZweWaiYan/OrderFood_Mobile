import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:deli_pos/component/myOrderCard.dart';

class MyorderPage extends StatefulWidget {
  const MyorderPage({super.key});

  @override
  State<MyorderPage> createState() => _MyorderPageState();
}

class _MyorderPageState extends State<MyorderPage> {
  int _selectedIndex = 0;

  final List<String> _tabs = ["Active", "Completed", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_left_rounded,
                      color: Color(0xFFFF8C00),
                      size: 30,
                    ),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/profilePage'),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'My Orders',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Tabs
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 0, 17, 15),
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  final isSelected = _selectedIndex == index;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Center(
                          child: Text(
                            _tabs[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        selected: isSelected,
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
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("myOrder")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;

                  final filtered = docs.where((doc) {
                    final status = doc["status"] ?? 0;

                    if (_selectedIndex == 0) {
                      return status == 0;
                    }
                    if (_selectedIndex == 1) return status == 1;
                    if (_selectedIndex == 2) return status == 2;

                    return false;
                  }).toList();

                  if (filtered.isEmpty) {
                    return const Center(child: Text("No orders found"));
                  }

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final order =
                            filtered[index].data() as Map<String, dynamic>;

                        return OrderCard(
                          imageUrl: order["imageUrl"] ?? "",
                          shopName: order["shopName"] ?? "Unknown Shop",
                          dateTime: order["dateTime"] ?? "",
                          items: order["items"] ?? "",
                          price: order["price"] ?? "",
                          status: order["status"] ?? 0,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
