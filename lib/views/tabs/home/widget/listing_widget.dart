import 'package:flutter/material.dart';
import 'package:mon_task/views/tabs/home/widget/widget.dart';


class ListingWidget extends StatelessWidget {
  const ListingWidget({
    super.key,
    required this.image,
    required this.address,
    required this.alignment,
  });

  final String image;
  final String address;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.bottomLeft,
          child: AnimatedButton(address: address, alignment: alignment),
        ),
      ],
    );
  }
}
