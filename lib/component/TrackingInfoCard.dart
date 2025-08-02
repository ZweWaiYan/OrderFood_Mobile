import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

class TrackingInfoCard extends StatefulWidget {
  const TrackingInfoCard({super.key});

  @override
  State<TrackingInfoCard> createState() => _TrackingInfoCardState();
}

class _TrackingInfoCardState extends State<TrackingInfoCard> {
  void makePhoneCall(String phoneNumber) async {
    Uri phoneUri;

    if (Platform.isAndroid) {
      // Android uses 'tel:' normally
      phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    } else if (Platform.isIOS) {
      // iOS also supports 'tel:', but this form ensures proper escaping
      phoneUri = Uri.parse('tel:$phoneNumber');
    } else {
      throw 'Unsupported platform';
    }

    if (!await launchUrl(phoneUri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch dialer for $phoneNumber';
    }
  }

  void sendSMS(String phoneNumber, String message) async {
    Uri smsUri;

    if (Platform.isAndroid) {
      // Android uses 'sms' scheme
      smsUri = Uri(
        scheme: 'sms',
        path: phoneNumber,
        queryParameters: {'body': message},
      );
    } else if (Platform.isIOS) {
      // iOS uses same scheme, but syntax is more picky
      smsUri = Uri.parse(
        'sms:$phoneNumber&body=${Uri.encodeComponent(message)}',
      );
    } else {
      throw 'Unsupported platform';
    }

    if (!await launchUrl(smsUri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch SMS app';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Container(
        width: double.infinity,
        height: 210,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 25),
          child: Column(
            children: [
              // Restaurant and Your Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.circle, color: Colors.orange, size: 15),
                      Container(width: 2, height: 48, color: Colors.grey),
                      const Icon(
                        Icons.location_on,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Yes Coffee Shop 2",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              Text(
                                " - ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              Text(
                                "13:00 PM",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Thanthumar Rd, Yangon",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "You",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              Text(
                                " - ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              Text(
                                "13:00 PM",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "49 Rd, South Okalapa, Yangon",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // Delivery Info
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset(
                              'assets/delivery.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "john wick",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "09123456789",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFBEFDC),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 210, 210, 210),
                                    blurRadius: 3,
                                    offset: Offset(-2, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.message_outlined,
                                color: Color(0xFFFE8C00),
                                size: 15,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                sendSMS('09769361178', '');
                              });
                            },
                          ),
                          const SizedBox(height: 5),
                          IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFBEFDC),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 210, 210, 210),
                                    blurRadius: 3,
                                    offset: Offset(-2, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.call,
                                color: Color(0xFFFE8C00),
                                size: 15,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                makePhoneCall('09769361178');
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
