import 'package:flutter/material.dart';
import 'package:flutter_riverpod_overview/feature/home/component/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;

  const HomeScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
