import 'package:flutter/material.dart';

class TrackingFloatingBtn extends StatefulWidget {
  final String backNav;
  final String titleName;

  const TrackingFloatingBtn({
    super.key,
    required this.titleName,
    required this.backNav,
  });

  @override
  State<TrackingFloatingBtn> createState() => _TrackingFloatingBtnState();
}

class _TrackingFloatingBtnState extends State<TrackingFloatingBtn> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred Header Bar
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_circle_left_rounded,
                        color: Color(0xFFFF8C00),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, widget.backNav);
                      },
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.titleName,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // ensure text is visible
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Zoom In
        Positioned(
          bottom: 55,
          right: 10,
          child: SizedBox(
            width: 35,
            height: 35,
            child: FloatingActionButton(
              onPressed: () {
                // Your action here
              },
              backgroundColor: Colors.white,
              foregroundColor: Colors.black, // Icon color
              child: const Icon(Icons.add, size: 15),
            ),
          ),
        ),

        //Zoom Out
        Positioned(
          bottom: 10,
          right: 10,
          child: SizedBox(
            width: 35,
            height: 35,
            child: FloatingActionButton(
              onPressed: () {
                // Your action here
              },
              backgroundColor: Colors.white,
              foregroundColor: Colors.black, // Icon color
              child: const Icon(Icons.remove, size: 15),
            ),
          ),
        ),

        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, color: Colors.green, size: 15),
                  SizedBox(width: 10),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      "Your order is on the way",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto',
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
