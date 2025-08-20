import 'package:flutter/material.dart';

class ChangePasswordInput extends StatefulWidget {
  const ChangePasswordInput({super.key});

  @override
  State<ChangePasswordInput> createState() => _ChangePasswordInputState();
}

class _ChangePasswordInputState extends State<ChangePasswordInput> {
  // Controllers for each password field
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Obscure toggles for each field
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  void _showChangePasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Text(
                    "Change Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password fields
                  _buildPasswordField(
                    "Current Password",
                    _currentPasswordController,
                    _obscureCurrent,
                    (val) => setState(() => _obscureCurrent = val),
                  ),
                  const SizedBox(height: 15),
                  _buildPasswordField(
                    "New Password",
                    _newPasswordController,
                    _obscureNew,
                    (val) => setState(() => _obscureNew = val),
                  ),
                  const SizedBox(height: 15),
                  _buildPasswordField(
                    "Confirm Password",
                    _confirmPasswordController,
                    _obscureConfirm,
                    (val) => setState(() => _obscureConfirm = val),
                  ),
                  const SizedBox(height: 25),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // handle save action here
                      },
                      child: const Text(
                        "Save Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    bool obscure,
    ValueChanged<bool> toggleObscure,
  ) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: label,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _showChangePasswordSheet(context),
        child: const Text("Change Password"),
      ),
    );
  }
}
