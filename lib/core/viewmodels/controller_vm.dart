import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mon_task/core/core.dart';
import 'package:mon_task/views/tabs/fave_tab.dart';
import 'package:mon_task/views/tabs/home/home_tab.dart';
import 'package:mon_task/views/tabs/message_tab.dart';
import 'package:mon_task/views/tabs/profile_tab.dart';
import 'package:mon_task/views/tabs/search/search_tab.dart';


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




  final List<SpaceListingModel> listings = [
   SpaceListingModel (
      address: 'Gladkova St., 25',
      image: 'https://cdn.pixabay.com/photo/2023/01/10/20/56/nyc-7710506_1280.jpg',
      mainAxis: 2,
      crossAxis: 1
    ),
  SpaceListingModel  (
      address: 'Gubina St., 11',
      image: 'https://cdn.pixabay.com/photo/2014/07/31/21/41/apartment-406901_1280.jpg',
      mainAxis: 1,
      crossAxis: 2
    ),
  SpaceListingModel  (
      address: 'Trefoleva St., 43',
      image: 'https://cdn.pixabay.com/photo/2018/05/25/17/52/home-3429674_1280.jpg',
      mainAxis: 1,
      crossAxis: 1
    ),
   SpaceListingModel (
      address: 'Sedova St., 22',
      image: 'https://cdn.pixabay.com/photo/2017/02/24/12/22/apartment-2094702_1280.jpg',
      mainAxis: 1,
      crossAxis: 1
    )
  ];

  int _currentTab = 2;
  int get currentTab => _currentTab;
  set currentTab(int val) {
    _currentTab = val;
    notifyListeners();
  }
}
