import 'package:flutter/material.dart';

class TrackingOrderListCard extends StatefulWidget {
  final VoidCallback onExpand;

  const TrackingOrderListCard({super.key, required this.onExpand});

  @override
  State<TrackingOrderListCard> createState() => _TrackingOrderListCardState();
}

class _TrackingOrderListCardState extends State<TrackingOrderListCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // always visible
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "See Your Items",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "total - 30",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Detail Button
                  GestureDetector(
                    onTap: widget.onExpand,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 5),
                      child: Container(
                        width: 60,
                        height: 25,
                        alignment: Alignment.center, // center text vertically
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 234, 197),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(-1, 1),
                            ),
                          ],
                        ),
                        child: const Text(
                          "Detail",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.orange,
                            fontFamily: 'DM Sans',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
