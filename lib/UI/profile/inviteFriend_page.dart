import 'package:flutter/material.dart';

class InvitefriendPage extends StatelessWidget {
  const InvitefriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                    'Invite Friends',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            //body
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // center whole column
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // center horizontally
                  children: [
                    buildIconBox('assets/tiktok.png'),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // evenly spread row items
                      children: [
                        buildIconBox('assets/fb.png'),
                        buildIconBox('assets/whatApp.png'),
                      ],
                    ),

                    const SizedBox(height: 12),

                    buildIconBox('assets/telegram.png'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconBox(String assetPath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6),
        ],
      ),
      padding: const EdgeInsets.all(10),
      width: 70,
      height: 70,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            assetPath,
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
