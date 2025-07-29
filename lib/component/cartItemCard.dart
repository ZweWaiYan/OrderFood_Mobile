import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int price;
  final String imagePath;
  final int quantity;
  final VoidCallback onDelete;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const ItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
    required this.quantity,
    required this.onDelete,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final int totalPrice = price * quantity;
    double deleteButtonWidth = 30;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart, // Swipe left to right
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(left: 14),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          // child: const Icon(
          //   Icons.delete_outline_rounded,
          //   color: Colors.white,
          //   size: 24,
          // ),
        ),
        confirmDismiss: (direction) async {
          // Optional: confirm dialog before deleting
          final shouldDelete = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Item'),
              content: const Text('Are you sure you want to remove this item?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete'),
                ),
              ],
            ),
          );
          if (shouldDelete ?? false) onDelete();
          return shouldDelete ?? false;
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Delete Button (to the right, behind)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 80,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 3),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),

              // Item Card (in front)
              Positioned(
                right: deleteButtonWidth, // More overlap
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width -
                      (deleteButtonWidth + 20), // 20 for horizontal padding
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2, 1),
                        blurRadius: 7,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/hambunger.jpg',
                          width: 70,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Text and Qty
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "CheeseBurger",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text("Wendy's Burger",
                                    style: TextStyle(fontSize: 8)),
                                const SizedBox(height: 6),
                                Text(
                                  '$totalPrice MMK',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            // Qty Buttons
                            Container(
                              height: 28,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                                // boxShadow: const [
                                //   BoxShadow(
                                //     color: Colors.black26,
                                //     offset: Offset(0, 2),
                                //     blurRadius: 6,
                                //   )
                                // ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  IconButton(
                                    onPressed: () => onDecrease(),
                                    icon: const Icon(Icons.remove,
                                        size: 18, color: Colors.white),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(
                                      '$quantity',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    onPressed: () => onIncrease(),
                                    icon: const Icon(Icons.add,
                                        size: 18, color: Colors.white),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
