import 'package:flutter/material.dart';
import 'package:flutter_riverpod_overview/app/app_router.dart';
import 'package:flutter_riverpod_overview/feature/home/component/bottom_nav_bar_item.dart';
import 'package:flutter_riverpod_overview/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  static final _tabs = [
    BottomNavBarItem(
      destination: RoutesNames.userList,
      icon: const Icon(Icons.person),
      label: S.current.users,
    ),
    BottomNavBarItem(
      destination: RoutesNames.postList,
      icon: const Icon(Icons.message),
      label: S.current.posts,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _tabs,
      onTap: (index) => _onItemTapped(context, index),
      currentIndex: _currentIndex(context),
    );
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex(context)) {
      context.go(_tabs[tabIndex].destination);
    }
  }

  int _currentIndex(BuildContext context) => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index = _tabs.indexWhere((tab) => location.startsWith(tab.destination));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }
}
