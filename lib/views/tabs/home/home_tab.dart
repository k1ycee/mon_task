import 'package:flutter/material.dart';
import 'package:mon_task/views/tabs/home/widget/space_listings.dart';
import 'package:mon_task/views/tabs/home/widget/top_section.dart';

class Hometab extends StatefulWidget {
  const Hometab({super.key});

  @override
  State<Hometab> createState() => _HometabState();
}

class _HometabState extends State<Hometab> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffFAD8AF), Color(0xffF8F8F8)],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext headerContext, bool boolean) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 440,
              flexibleSpace: FlexibleSpaceBar(background: HomeTopSection()),
            ),
          ];
        },
        body: SpaceListings(),
      ),
    );
  }
}
