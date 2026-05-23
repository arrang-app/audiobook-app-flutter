import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';

class AudioBookApp extends ConsumerWidget {
  const AudioBookApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.theme;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Aurora Audio',
      theme: theme,
      routeInformationParser: appRouter.routeInformationParser,
      routerDelegate: appRouter.routerDelegate,
      routeInformationProvider: appRouter.routeInformationProvider,
      restorationScopeId: 'audio_book_app',
    );
  }
}
