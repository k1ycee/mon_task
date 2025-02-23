import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mon_task/utils/constant/map_style.dart';
import 'package:mon_task/views/tabs/search/widget/marker_widget.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(59.9527, 30.4166),
    zoom: 16,
  );

  Set<Marker> _markers = {};

  Future<void> _initializeMarkers() async {
    final markers = {
      Marker(
        markerId: MarkerId("okhta_residence_1"),
        position: LatLng(59.9508, 30.4125),
        icon: await const MarkerWidget(title: "10,3 mn P").toBitmapDescriptor(),
      ),
      Marker(
        markerId: MarkerId("okhta_residence_2"),
        position: LatLng(59.9514, 30.4142),
        icon: await const MarkerWidget(title: "11 mn P").toBitmapDescriptor(),
      ),
      Marker(
        markerId: MarkerId("okhta_riverside_apartments"),
        position: LatLng(59.9520, 30.4158),
        icon: await const MarkerWidget(title: "7,8 mn P").toBitmapDescriptor(),
      ),
      Marker(
        markerId: MarkerId("novaya_okhta_complex"),
        position: LatLng(59.9532, 30.4175),
        icon: await const MarkerWidget(title: "8,5 mn P").toBitmapDescriptor(),
      ),
      Marker(
        markerId: MarkerId("malaya_okhta_residential"),
        position: LatLng(59.9540, 30.4191),
        icon: await const MarkerWidget(title: "13,3 mn P").toBitmapDescriptor(),
      ),
      Marker(
        markerId: MarkerId("glorax_okhta_living"),
        position: LatLng(59.9548, 30.4205),
        icon: await const MarkerWidget(title: "6,95 mn P").toBitmapDescriptor(),
      ),
    };

    setState(() {
      _markers = markers;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((time) async {
      await _initializeMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.terrain,
          compassEnabled: false,
          initialCameraPosition: _initialPosition,
          style: mapStyle,
          markers: _markers,
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController controller) async {
            _controller.complete(controller);

          },
        ),
                SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AnimatedScale(
                        scale:  1 ,
                        duration: const Duration(milliseconds: 700),
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Iconsax.search_normal_1),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Saint Petersburg',
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                    const SizedBox(width: 10),
                    AnimatedScale(
                      scale:  1,
                      duration: const Duration(milliseconds: 700),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffffffff), shape: BoxShape.circle),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Iconsax.candle_2,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
