import 'package:flutter/material.dart';
import 'package:mon_task/core/core.dart';

class MarkerWidget extends StatelessWidget {
  const MarkerWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 95,
      decoration: const BoxDecoration(
        color: Color(0xfffc9f12),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              // textDirection: Tr,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppTheme.light.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
