import 'package:deli_pos/component/OTPInputWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ForgetpasswordPage extends StatefulWidget {
  const ForgetpasswordPage({super.key});

  @override
  State<ForgetpasswordPage> createState() => _ForgetpasswordPageState();
}

class _ForgetpasswordPageState extends State<ForgetpasswordPage> {
  final _passwordController = TextEditingController();
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {}); // rebuild to update button enable/disable
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushReplacementNamed(context, '/securityPage');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // PageView
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics:
                      const NeverScrollableScrollPhysics(), // prevent swipe
                  children: [forgetPasswordWidget(), checkEmailWidget()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget forgetPasswordWidget() {
    return Column(
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
                    Navigator.pushReplacementNamed(context, '/securityPage'),
              ),
              const SizedBox(width: 5),
              const Text(
                'Forget Password',
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
              const Text(
                'Please enter your email to reset the password',
                style: TextStyle(
                  color: Color(0xFF878787),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Your Email',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
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
                    borderSide: const BorderSide(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _passwordController.text.isNotEmpty
                      ? () {
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Reset Password',
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
    );
  }

  Widget checkEmailWidget() {
    return Column(
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
                    // Navigator.pushReplacementNamed(context, '/securityPage'),
                    {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      ),
                    },
              ),
              const SizedBox(width: 5),
              const Text(
                'Check Your Email',
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
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Text
                const Text(
                  'We sent a reset link to mew@example.com enter 5 digit code that mentioned in the email',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xFF878787),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: OTPInputWidget(),
                ),

                const SizedBox(height: 30),

                //Btn
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _dialogBuilder(context),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Verify Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                //Resend text
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Color(0xFF878787),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(text: "Haven’t got the email yet? "),
                      TextSpan(
                        text: "Resend email",
                        style: const TextStyle(
                          color: Colors.orange, // link color
                          decoration:
                              TextDecoration.underline, // optional underline
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Your resend email logic
                            print("Resend email clicked");
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Password Reset',
                style: TextStyle(
                  color: Color(0xFFFE8C00),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              const Text(
                textAlign: TextAlign.center,
                'Your password has been successfully reset. clickconfirm to set a new password',
                style: TextStyle(
                  color: Color(0xFF989898),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      '/mainNewPasswordPage',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
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
        );
      },
    );
  }
}
