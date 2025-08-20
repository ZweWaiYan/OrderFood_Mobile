import 'package:deli_pos/component/TrackingDetailItem.dart';
import 'package:deli_pos/component/TrackingFloatingBtn.dart';
import 'package:deli_pos/component/TrackingInfoCard.dart';
import 'package:deli_pos/component/TrackingOrderIlistCard.dart';
import 'package:deli_pos/filterData/filter_data.dart';
import 'package:deli_pos/helperFun/calculateTotalPrice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  final MapController _mapController = MapController();

  LatLng myLatLng = const LatLng(16.8713, 96.1994);

  bool _isDetailExpaned = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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

                  TrackingFloatingBtn(titleName: 'Tracking', backNav: "/"),
                ],
              ),
            ),

            // Bottom half - Orange container
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _isDetailExpaned
                  ? MediaQuery.of(context).size.height
                  : MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "Order #PIZ6754",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    const TrackingInfoCard(),
                    TrackingOrderListCard(
                      onExpand: () {
                        setState(() {
                          _isDetailExpaned = !_isDetailExpaned;
                        });
                      },
                    ),

                    // Tracking Detail Item Section (only show when expanded)
                    if (_isDetailExpaned)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              ListView.builder(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: Trackingitems.length,
                                itemBuilder: (context, index) {
                                  final item = Trackingitems[index];
                                  return TrackingDetailItem(
                                    name: item["name"]?.toString() ?? "Unknown",
                                    price: item["price"] is int
                                        ? item["price"] as int
                                        : 0,
                                    qty: item["qty"] is int
                                        ? item["qty"] as int
                                        : 1,
                                    image:
                                        item["image"]?.toString() ??
                                        "assets/default.jpg",
                                  );
                                },
                              ),

                              // Total Price with top border and horizontal padding
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Total",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'DM Sans',
                                          ),
                                        ),
                                        Text(
                                          "${calculateTotalPrice(Trackingitems)} Ks",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'DM Sans',
                                          ),
                                        ),
                                      ],
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
          ],
        ),
      ),
    );
  }
}
