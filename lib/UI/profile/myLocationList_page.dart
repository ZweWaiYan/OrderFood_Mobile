import 'package:deli_pos/component/myLocationListCard.dart';
import 'package:flutter/material.dart';

class MylocationlistPage extends StatefulWidget {
  const MylocationlistPage({super.key});

  @override
  State<MylocationlistPage> createState() => _MylocationlistPageState();
}

class _MylocationlistPageState extends State<MylocationlistPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    Map<dynamic, dynamic> data = {};

    if (args != null && args is Map) {
      data = args;
    }

    final fromWhere = data['fromWhere'] ?? '/defaultRoute';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_left_rounded,
                      color: Color(0xFFFF8C00),
                      size: 30,
                    ),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, fromWhere),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'My Location Lists',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            //body
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Mylocationlistcard(),
            ),

            Padding(
              padding: const EdgeInsets.all(11.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, fromWhere);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'New location',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
