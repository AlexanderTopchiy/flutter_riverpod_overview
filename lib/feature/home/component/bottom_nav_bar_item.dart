import 'package:flutter/material.dart';

class BottomNavBarItem extends BottomNavigationBarItem {
  final String destination;

  const BottomNavBarItem({
    required this.destination,
    required Widget icon,
    required String label,
  }) : super(
          icon: icon,
          label: label,
        );
}
