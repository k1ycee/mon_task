import 'package:flutter/material.dart';

class ControllerPageModel {
  const ControllerPageModel({
    required this.icon,
    required this.name,
    required this.page,
  });

  final Widget page;
  final String name;
  final IconData icon;
}