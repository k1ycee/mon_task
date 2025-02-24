import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mon_task/core/viewmodels/providers.dart';
import 'package:mon_task/utils/constant/map_style.dart';
import 'package:mon_task/views/tabs/search/widget/marker_widget.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class SearchTab extends StatefulHookConsumerWidget {
  const SearchTab({super.key});

  @override
  ConsumerState<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends ConsumerState<SearchTab>
    with TickerProviderStateMixin {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(59.9527, 30.4166),
    zoom: 16,
  );

  late AnimationController _animationController;
  late Animation<double> _animation;

  late AnimationController _optionAnimationController;
  late Animation<double> _optionAnimation;

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

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _optionAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _optionAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _optionAnimationController, curve: Curves.easeIn),
    );

    WidgetsBinding.instance.addPostFrameCallback((time) async {
      _animationController.forward();
      await _initializeMarkers();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final options = ref.watch(searchVM.select((value) => value.mapOptions));
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
        AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ScaleTransition(
                            scale: _animation,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Iconsax.search_normal_1),
                                  SizedBox(width: 10),
                                  Opacity(
                                    opacity: _animation.value,
                                    child: Text(
                                      'Saint Petersburg',
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ScaleTransition(
                          scale: _animation,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Opacity(
                                opacity: _animation.value,
                                child: Icon(
                                  Iconsax.candle_2,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Positioned(
              bottom: 100,
              left: 30,
              child: ScaleTransition(
                scale: _animation,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _optionAnimationController.forward(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff737373).withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.layers, color: Color(0xffffffff)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff737373).withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(
                          child: Transform.rotate(
                            angle: -45,
                            child: Icon(
                              Iconsax.send_1,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        Positioned(
          bottom: 155,
          left: 30,
          child: ScaleTransition(
            alignment: Alignment.bottomLeft,
            scale: _optionAnimation,
            child: GestureDetector(
              onTap: () {
                _optionAnimationController.reverse();
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        options.indexed.map((item) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  item.$2.icon,
                                  color:
                                      item.$1 == 1
                                          ? const Color(0xfffc9f12)
                                          : const Color(0xff737373),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  item.$2.name,
                                  style: TextStyle(
                                    color:
                                        item.$1 == 1
                                            ? const Color(0xfffc9f12)
                                            : const Color(0xff737373),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),

        AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Positioned(
              bottom: 100,
              right: 30,
              child: ScaleTransition(
                scale: _animation,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff737373).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      left: 18,
                      right: 18,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.menu, color: Color(0xffffffff)),
                        SizedBox(width: 10),
                        Text(
                          'List of variants',
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
