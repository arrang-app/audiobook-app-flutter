import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      context.go('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF7A5C), Color(0xFFC93A6B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.12),
                    blurRadius: 30,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Icon(Icons.headset, size: 56, color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text(
              'Aurora Audio',
              style: TextStyle(
                fontFamily: 'Fredoka',
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Premium listening with premium design',
              style: TextStyle(
                color: Color(0xFFC6C6C6),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
