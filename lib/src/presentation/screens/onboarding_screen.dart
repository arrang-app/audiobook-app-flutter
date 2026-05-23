import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => context.go('/auth'),
                  child: const Text('Skip', style: TextStyle(color: Colors.white70)),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Listen in luxury',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 16),
              const Text(
                'Discover audiobooks, curated collections, and immersive chapters with a premium dark layout built for focus and flow.',
                style: TextStyle(color: Color(0xFFC6C6C6), fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 32),
              _FeatureTile(
                label: 'Seamless background playback',
                icon: Icons.cloud_done,
              ),
              _FeatureTile(
                label: 'Persistent notifications & lockscreen controls',
                icon: Icons.notifications_active,
              ),
              _FeatureTile(
                label: 'Smart queue with chapters and bookmarks',
                icon: Icons.queue_music,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.go('/auth'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF47051),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  minimumSize: const Size.fromHeight(58),
                ),
                child: const Text('Start Listening', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFFF47051), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
