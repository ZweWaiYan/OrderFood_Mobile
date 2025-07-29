import 'package:flutter/material.dart';

class SuccessfulModal extends StatefulWidget {
  const SuccessfulModal({super.key});

  @override
  State<SuccessfulModal> createState() => _SuccessfulModalState();
}

class _SuccessfulModalState extends State<SuccessfulModal> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Top header bar
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_circle_left_rounded,
                        color: Color(0xFFFF8C00),
                      ),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/'),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Receipt",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Centered white container with content
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 450,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white, // white background only here
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 213, 234, 214),
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 50,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Payment Successful!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Your payment was processed successfully!',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 220,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Transaction Detail",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.download,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: Image.asset(
                                                "assets/dots.png",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Transaction ID",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              110,
                                              110,
                                              110,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "8DS2-192F-84T7",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              110,
                                              110,
                                              110,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Amount",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              110,
                                              110,
                                              110,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "35000 Ks",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              110,
                                              110,
                                              110,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Date",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              110,
                                              110,
                                              110,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "15.July.2025",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              110,
                                              110,
                                              110,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Type",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              110,
                                              110,
                                              110,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Wavepay",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              110,
                                              110,
                                              110,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Status",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              110,
                                              110,
                                              110,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Success",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              110,
                                              110,
                                              110,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Continue Btn
                      Padding(
                        padding: const EdgeInsets.all(27.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/trackPage');
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text(
                                "Continue Tracking",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
