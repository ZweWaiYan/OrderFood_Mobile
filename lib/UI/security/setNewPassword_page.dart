import 'package:flutter/material.dart';

class SetnewpasswordPage extends StatefulWidget {
  const SetnewpasswordPage({super.key});

  @override
  State<SetnewpasswordPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SetnewpasswordPage> {
  // Controllers for each password field
  final _passwordController = TextEditingController();
  final _comfirmPasswordController = TextEditingController();

  // Obscure toggles for each field
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      '/forgetpasswordPage',
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Set A New Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPasswordField(
                    "Password",
                    _passwordController,
                    _obscurePassword,
                    (val) => setState(() => _obscurePassword = val),
                  ),

                  const SizedBox(height: 30),

                  _buildPasswordField(
                    "Confirm Password",
                    _comfirmPasswordController,
                    _obscureConfirmPassword,
                    (val) => setState(() => _obscureConfirmPassword = val),
                  ),

                  const SizedBox(height: 50),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Update Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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

  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    bool obscure,
    ValueChanged<bool> toggleObscure,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 15),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 255, 206, 132),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.orange, width: 2),
            ),
            hintText: 'Enter $label',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                toggleObscure(!obscure);
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label is required';
            } else if (value.length < 6) {
              return '$label must be at least 6 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
