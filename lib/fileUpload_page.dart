import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FileuploadPage extends StatefulWidget {
  const FileuploadPage({super.key});

  @override
  State<FileuploadPage> createState() => _FileuploadPageState();
}

class _FileuploadPageState extends State<FileuploadPage> {
  final _formKey = GlobalKey<FormState>();

  final shopkeeperController = TextEditingController();
  final shopController = TextEditingController();
  final qtyController = TextEditingController();
  final shopCodeController = TextEditingController();
  final phoneController = TextEditingController();
  final shopTypeController = TextEditingController();
  final addressController = TextEditingController();
  final locationController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text("Add Product")),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField(
                            shopkeeperController,
                            "ShopKeeper Name",
                          ),
                          _buildTextField(shopController, "Shop Name"),
                          _buildTextField(
                            qtyController,
                            "Number of Items",
                            isNumber: true,
                          ),
                          _buildTextField(
                            shopCodeController,
                            "Shop Code",
                            isNumber: true,
                          ),
                          _buildTextField(phoneController, "Phone Number"),
                          _buildTextField(shopTypeController, "Shop Type"),
                          _buildTextField(addressController, "Address"),
                          _buildTextField(
                            locationController,
                            "Enter location or coordinates",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => isLoading = true);
                              try {
                                // Create a map of the shop data
                                Map<String, dynamic> shopData = {
                                  'shopkeeper': shopkeeperController.text
                                      .trim(),
                                  'shop': shopController.text.trim(),
                                  'qty':
                                      int.tryParse(qtyController.text.trim()) ??
                                      0,
                                  'shopCode':
                                      int.tryParse(
                                        shopCodeController.text.trim(),
                                      ) ??
                                      0,
                                  'phone': phoneController.text.trim(),
                                  'shopType': shopTypeController.text.trim(),
                                  'address': addressController.text.trim(),
                                  'location': locationController.text.trim(),
                                };

                                // Save to Firestore
                                await FirebaseFirestore.instance
                                    .collection('meals') // your collection name
                                    .add(shopData);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Shop info saved to Firestore!',
                                    ),
                                  ),
                                );

                                Navigator.pushReplacementNamed(context, '/');
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              } finally {
                                setState(() => isLoading = false);
                              }
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        if (isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white, // White input background
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Enter $label' : null,
      ),
    );
  }
}
