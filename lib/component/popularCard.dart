import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PopularCard extends StatelessWidget {
  final dynamic name, price, imageUrl, description;
  final bool isLoading;

  const PopularCard({
    super.key,
    this.name,
    this.price,
    this.imageUrl,
    this.description,
    this.isLoading = false, // Add this flag to control loading state
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Shimmer loading UI
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
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(height: 16, width: 100, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(height: 12, width: 70, color: Colors.white),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(height: 14, width: 30, color: Colors.white),
                      Container(height: 14, width: 30, color: Colors.white),
                      Container(height: 14, width: 20, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Normal loaded UI
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
              Stack(
                children: [
                  Hero(
                    tag: name,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // (rest of your overlays like favorite, bag count, price)
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
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
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
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        '$price MMK',
                        style: const TextStyle(
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
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                ),
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
