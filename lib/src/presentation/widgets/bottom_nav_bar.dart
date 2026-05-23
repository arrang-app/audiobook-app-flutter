import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({required this.selectedIndex, super.key});

  final int selectedIndex;

  static const _routes = ['/home', '/library', '/search'];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 72,
      selectedIndex: selectedIndex,
      backgroundColor: const Color(0xFF101010),
      onDestinationSelected: (index) {
        context.go(_routes[index]);
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.library_books_outlined), selectedIcon: Icon(Icons.library_books), label: 'Library'),
        NavigationDestination(icon: Icon(Icons.search), selectedIcon: Icon(Icons.search_rounded), label: 'Search'),
      ],
    );
  }
}
