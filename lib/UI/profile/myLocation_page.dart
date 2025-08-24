import 'package:deli_pos/component/TrackingFloatingBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MylocationPage extends StatefulWidget {
  const MylocationPage({super.key});

  @override
  State<MylocationPage> createState() => _MylocationPageState();
}

class _MylocationPageState extends State<MylocationPage> {
  final MapController _mapController = MapController();

  LatLng myLatLng = const LatLng(16.8713, 96.1994);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    Map<dynamic, dynamic> data = {};

    if (args != null && args is Map) {
      data = args;
    }

    final fromWhere = data['fromWhere'] ?? '/defaultRoute';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Top half - Map
          Expanded(
            child: Stack(
              children: [
                // Map
                FlutterMap(
                  mapController: _mapController,
                  options: const MapOptions(
                    initialCenter: LatLng(16.8713, 96.1994),
                    initialZoom: 13,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'com.deli_pos',
                    ),
                  ],
                ),

                TrackingFloatingBtn(
                  titleName: 'My Location',
                  backNav: fromWhere,
                ),
              ],
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(23.0),
              child: Column(
                children: [
                  // My Location
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 10),
                        child: Text(
                          'Your Location',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/myLocationlistPage',
                            );
                          },
                          child: const Center(
                            child: Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.orange),
                                SizedBox(width: 10),
                                Text(
                                  'Order now',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Name input
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Text(
                          'Mark Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 13),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'eg: Home',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 50),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Save Location',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
    );
  }
}
