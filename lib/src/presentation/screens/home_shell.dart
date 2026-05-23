import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({required this.child, super.key});

  final Widget child;

  int _selectedIndex(String location) {
    if (location.startsWith('/search')) return 2;
    if (location.startsWith('/library')) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNavBar(selectedIndex: _selectedIndex(location)),
    );
  }
}
