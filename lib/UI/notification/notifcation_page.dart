import 'package:flutter/material.dart';

class NotifcationPage extends StatefulWidget {
  const NotifcationPage({super.key});

  @override
  State<NotifcationPage> createState() => _NotifcationPageState();
}

class _NotifcationPageState extends State<NotifcationPage> {
  int _selectedIndex = 0;

  final List<String> _tabs = ["All", "System", "User"];

  @override
  Widget build(BuildContext context) {
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
                        Navigator.pushReplacementNamed(context, '/'),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Tabs
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 0, 17, 15),
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  final isSelected = _selectedIndex == index;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _tabs[index],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.orange,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              ' (30)',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.orange,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        selected: isSelected,
                        showCheckmark: false,
                        selectedColor: Colors.orange,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.orange),
                        ),
                        onSelected: (_) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
