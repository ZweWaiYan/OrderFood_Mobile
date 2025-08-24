import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deli_pos/component/notiCard.dart';
import 'package:flutter/material.dart';

class NotifcationPage extends StatefulWidget {
  const NotifcationPage({super.key});

  @override
  State<NotifcationPage> createState() => _NotifcationPageState();
}

class _NotifcationPageState extends State<NotifcationPage> {
  int _selectedIndex = 0;
  final List<String> _tabs = ["All", "System", "User"];

  Map<String, List<QueryDocumentSnapshot>> groupNotificationsByDate(
    List<QueryDocumentSnapshot> docs,
  ) {
    final Map<String, List<QueryDocumentSnapshot>> grouped = {};

    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    for (var doc in docs) {
      final dateStr = doc['orderDate']; // format: '20/08/2025'
      final parts = dateStr.split('/');
      final date = DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );

      String key;
      if (date.year == today.year &&
          date.month == today.month &&
          date.day == today.day) {
        key = 'Today';
      } else if (date.year == yesterday.year &&
          date.month == yesterday.month &&
          date.day == yesterday.day) {
        key = 'Yesterday';
      } else {
        key = dateStr; // fallback: show the actual date
      }

      if (!grouped.containsKey(key)) grouped[key] = [];
      grouped[key]!.add(doc);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
              // Header
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
                          'Notifications',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          icon: const Icon(
                            Icons.more_vert_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                          onSelected: (value) {
                            if (value == "delete") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Delete clicked")),
                              );
                            } else if (value == "read") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Marked all as read"),
                                ),
                              );
                            } else if (value == "setting") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Settings clicked"),
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: "delete",
                              child: Text("Delete"),
                            ),
                            PopupMenuDivider(),
                            const PopupMenuItem(
                              value: "read",
                              child: Text("Mark all as read"),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem(
                              value: "setting",
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/profilePage');
                                },
                                child: const Text("Setting"),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                ' (30)',
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.orange,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
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
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('notification')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  // Use the separate function
                  final grouped = groupNotificationsByDate(snapshot.data!.docs);

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                      child: ListView(
                        children: grouped.entries.map((entry) {
                          final dateTitle = entry.key;
                          final notifications = entry.value;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Date header
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  dateTitle,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                              // Notification cards
                              ...notifications.map((notification) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/successfulModal',
                                      );
                                    },
                                    // borderRadius: BorderRadius.circular(8),
                                    child: NotiCard(
                                      isLoading: true,
                                      orderTitle: notification['orderTitle'],
                                      orderType: notification['orderType'],
                                      orderDes: notification['orderDes'],
                                      orderDate: notification['orderDate'],
                                      orderTime: notification['orderTime'],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
