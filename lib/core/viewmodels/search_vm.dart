import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mon_task/core/core.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel(this.ref);

  final Ref ref;

  final mapOptions = const <MapOptionsModel>[
    MapOptionsModel(
      icon: Iconsax.shield_tick,
      name: 'Cosy areas',
    ),
    MapOptionsModel(
      icon: Iconsax.empty_wallet,
      name: 'Price',
    ),
    MapOptionsModel(
      icon: Iconsax.bag,
      name: 'Infrastructure',
    ),
    MapOptionsModel(
      icon: Iconsax.layer,
      name: 'Without any layer',
    ),
  ];
}
