import 'package:flutter/material.dart';

class Mylocationlistcard extends StatelessWidget {
  final List<Map<String, dynamic>> locations = [
    {
      "icon": Icons.home,
      "label": "Home",
      "address": "49th blah blah, Yangon",
    },
    {
      "icon": Icons.work,
      "label": "Work",
      "address": "49th blah blah, Yangon",
    },
  ];

  Mylocationlistcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: locations.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left icon
              Icon(item["icon"], color: Colors.orange, size: 28),

              const SizedBox(width: 12),

              // Title + address
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["label"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item["address"],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF878787), // gray text
                      ),
                    ),
                  ],
                ),
              ),

              // Edit + Divider + Delete
              Row(
                children: [
                  Icon(Icons.edit, color: Colors.orange),
                  Container(
                    height: 20,
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    color: Colors.grey.shade300,
                  ),
                  Icon(Icons.delete, color: Colors.red),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
