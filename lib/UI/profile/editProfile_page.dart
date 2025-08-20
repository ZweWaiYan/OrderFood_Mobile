import 'package:flutter/material.dart';

class EditprofilePage extends StatefulWidget {
  const EditprofilePage({super.key});

  @override
  State<EditprofilePage> createState() => _EditprofilePageState();
}

class _EditprofilePageState extends State<EditprofilePage> {
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
                    'Edit Profile',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Full Name
            _buildTextField("Full Name", "eg. Mg Mg"),
            const SizedBox(height: 20),

            // Phone Number
            _buildTextField("Phone Number", "eg. 09XXXXXXXXX"),
            const SizedBox(height: 20),

            // Email
            _buildTextField("Email", "eg. example@gmail.com"),
          ],
        ),
      ),
    );
  }

  // Reusable textfield
  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: TextField(
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFFE8C00),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFFE8C00),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
