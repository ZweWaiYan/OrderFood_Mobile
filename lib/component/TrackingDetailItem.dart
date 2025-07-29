import 'package:flutter/material.dart';

class TrackingDetailItem extends StatelessWidget {
  final String name;
  final int price;
  final int qty;
  final String image;

  const TrackingDetailItem({
    super.key,
    required this.name,
    required this.price,
    required this.qty,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final int total = price * qty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: image + name + qty x price
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(image, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "$price",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("x"),
                          const SizedBox(width: 5),
                          Text(
                            "$qty",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // Right side: total
              Text(
                "$total Ks",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DM Sans',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
