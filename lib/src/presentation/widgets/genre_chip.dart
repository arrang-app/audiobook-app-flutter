import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  const GenreChip({required this.label, super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF101010),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Text(label, style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 14)),
    );
  }
}
