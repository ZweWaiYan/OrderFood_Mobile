import 'package:flutter/material.dart';

class Allshopcard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String avatarUrl;
  final double rating;
  final String time;

  const Allshopcard({
    super.key,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.avatarUrl,
    required this.rating,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Info Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),

          // Bottom Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                // Rating
                const Icon(Icons.star, color: Colors.orange, size: 18),
                const SizedBox(width: 4),
                Text(rating.toString(), style: const TextStyle(fontSize: 14)),

                const SizedBox(width: 16),

                // Time
                const Icon(
                  Icons.access_time_filled,
                  color: Colors.orange,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(time, style: const TextStyle(fontSize: 14)),

                // Divider Line
                const SizedBox(width: 30),
                Container(height: 40, width: 3, color: Colors.orange),
                const SizedBox(width: 16),

                // Button
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/menuPage');
                      },

                      child: const Text(
                        "See Menus...",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
