import 'package:flutter/material.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(9, 8, 9, 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: SizedBox(
        width: 140,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with overlays
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/pizza.png',
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Heart icon (top-right)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),

                  // Buy count (top-left)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/bag.png',
                            width: 16,
                            height: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '2.3K',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Price (bottom-right)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        '20,000 MMK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              const Text(
                'Delicious Pizza',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Pizza shop',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),

              const Spacer(),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 14),
                      SizedBox(width: 2),
                      Text('4.5', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.grey, size: 14),
                      SizedBox(width: 2),
                      Text('30 min', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Icon(Icons.shopping_cart_outlined, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
