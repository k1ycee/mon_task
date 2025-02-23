import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_task/core/core.dart';



class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this.ref);

  final Ref ref;





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

}
