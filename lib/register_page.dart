import 'dart:io';

import 'package:deli_pos/filterData/filter_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _qtyController = TextEditingController();

  bool _obscurePassword = true;

  signuptype? _character = signuptype.user;

  @override
  Widget build(BuildContext context) {
    File? pickedImage;

    Future<void> pickImage() async {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          pickedImage = File(pickedFile.path);
        });
      }
    }

    void showTermsDialog(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: true, // User can tap outside to close
        builder: (BuildContext context) {
          bool isChecked = false;

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Terms & Privacy Policy'),
                content: SizedBox(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '''Welcome to our app. By using this application, you agree to the following terms and conditions:

1. You agree not to misuse the service.
2. You acknowledge that the content provided is for informational purposes only.
3. We collect data to improve the user experience. Your privacy is important to us.
4. Any updates to these terms will be reflected in the app or communicated via email.

Please read carefully before accepting.''',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                'I agree to the terms above.',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text("Decline"),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    onPressed: isChecked
                        ? () {
                            Navigator.pushNamed(context, '/loginPage');
                          }
                        : null,
                    child: Text("Accept"),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return PopScope(
      canPop: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 200,
                              width: 200,
                              child: LottieBuilder.asset('assets/login.json'),
                            ),
                            const Text(
                              "Create new account",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        hintText: 'Enter your name',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Name is required';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: 'Enter your Gamil Address',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Email is required';
                                        } else if (!value.endsWith(
                                          '@gmail.com',
                                        )) {
                                          return 'Email must end with @gmail.com';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        hintText: 'Enter your Password',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Password is required';
                                        } else if (value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Radio<signuptype>(
                                                  value: signuptype.user,
                                                  groupValue: _character,
                                                  onChanged:
                                                      (signuptype? value) {
                                                        setState(() {
                                                          _character = value!;
                                                        });
                                                      },
                                                ),
                                                const Text('User'),
                                              ],
                                            ),
                                            const SizedBox(width: 20),
                                            Row(
                                              children: [
                                                Radio<signuptype>(
                                                  value: signuptype.shopkeeper,
                                                  groupValue: _character,
                                                  onChanged:
                                                      (signuptype? value) {
                                                        setState(() {
                                                          _character = value!;
                                                        });
                                                      },
                                                ),
                                                const Text('Shopkeeper'),
                                              ],
                                            ),
                                          ],
                                        ),

                                        if (_character ==
                                            signuptype.shopkeeper) ...[
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            controller: _shopNameController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelText: 'Shop Name',
                                              hintText: 'Enter your shop name',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Shop name is required';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              // Quantity field (takes more space)
                                              Expanded(
                                                flex: 3,
                                                child: TextFormField(
                                                  controller: _qtyController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: 'Menu Quantity',
                                                    hintText:
                                                        'Enter menu quantity',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Quantity is required';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (value) {
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 12),

                                              // Image Picker (takes less space)
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      168,
                                                      168,
                                                      151,
                                                    ),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: GestureDetector(
                                                  onTap: pickImage,
                                                  child: pickedImage == null
                                                      ? const Icon(
                                                          Icons.add,
                                                          color: Colors.orange,
                                                          size: 30,
                                                        )
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                          child: Image.file(
                                                            pickedImage!,
                                                            fit: BoxFit.cover,
                                                            width: 50,
                                                            height: 50,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                              ),
                              child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // if (_formKey.currentState!.validate()) {
                                    //   Navigator.pushNamed(
                                    //     context,
                                    //     '/loginPage',
                                    //   );
                                    // }

                                    if (_formKey.currentState!.validate()) {
                                      showTermsDialog(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      255,
                                      234,
                                      197,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account?"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/loginPage');
                                  },
                                  child: const Text("Login"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
