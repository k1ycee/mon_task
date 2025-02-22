import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mon_task/core/core.dart';
import 'package:mon_task/views/tabs/fave_tab.dart';
import 'package:mon_task/views/tabs/home/home_tab.dart';
import 'package:mon_task/views/tabs/message_tab.dart';
import 'package:mon_task/views/tabs/profile_tab.dart';
import 'package:mon_task/views/tabs/search_tab.dart';


class ControllerViewModel extends ChangeNotifier {
  ControllerViewModel(this.ref);

  final Ref ref;

  final pages = <ControllerPageModel>[
    ControllerPageModel(
      icon: Iconsax.search_normal_15,
      name: 'Search',
      page: SearchTab(),
    ),
    ControllerPageModel(
      icon: Iconsax.message5,
      name: 'Message',
      page: MessagesTab(),
    ),
    ControllerPageModel(icon: Iconsax.home5, name: 'Home', page: Hometab()),
    ControllerPageModel(icon: Iconsax.heart5, name: 'Fave', page: FaveTab()),
    ControllerPageModel(
      icon: Iconsax.profile_tick5,
      name: 'Profile',
      page: ProfileTab(),
    ),
  ];

  int _currentTab = 2;
  int get currentTab => _currentTab;
  set currentTab(int val) {
    _currentTab = val;
    notifyListeners();
  }
}
