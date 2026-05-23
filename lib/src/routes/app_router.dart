import 'package:go_router/go_router.dart';
import '../presentation/screens/auth_screen.dart';
import '../presentation/screens/details_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/home_shell.dart';
import '../presentation/screens/library_screen.dart';
import '../presentation/screens/onboarding_screen.dart';
import '../presentation/screens/player_screen.dart';
import '../presentation/screens/search_screen.dart';
import '../presentation/screens/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: <RouteBase>[
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => HomeShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/library',
          builder: (context, state) => const LibraryScreen(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DetailsScreen(audiobookId: id);
      },
    ),
    GoRoute(
      path: '/player/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return PlayerScreen(audiobookId: id);
      },
    ),
  ],
);
