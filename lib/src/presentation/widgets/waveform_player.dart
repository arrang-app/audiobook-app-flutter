import 'package:flutter/material.dart';

class WaveformPlayer extends StatelessWidget {
  const WaveformPlayer({
    required this.progress,
    required this.buffered,
    required this.onSeek,
    super.key,
  });

  final double progress;
  final double buffered;
  final ValueChanged<double> onSeek;

  @override
  Widget build(BuildContext context) {
    final barHeight = 6.0;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragUpdate: (details) {
        final box = context.size;
        if (box == null) return;
        final dx = details.localPosition.dx.clamp(0, box.width);
        onSeek(dx / box.width);
      },
      onTapDown: (event) {
        final box = context.size;
        if (box == null) return;
        onSeek(event.localPosition.dx.clamp(0, box.width) / box.width);
      },
      child: SizedBox(
        height: 40,
        child: Center(
          child: Stack(
            children: [
              Container(
                height: barHeight,
                decoration: BoxDecoration(
                  color: const Color(0xFF222222),
                  borderRadius: BorderRadius.circular(barHeight),
                ),
              ),
              FractionallySizedBox(
                widthFactor: buffered.clamp(0, 1),
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: const Color(0xFF444444),
                    borderRadius: BorderRadius.circular(barHeight),
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress.clamp(0, 1),
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF47051),
                    borderRadius: BorderRadius.circular(barHeight),
                  ),
                ),
              ),
              Positioned(
                left: (MediaQuery.of(context).size.width - 48) * progress.clamp(0, 1).clamp(0, 1),
                top: -8,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF47051),
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 8)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
