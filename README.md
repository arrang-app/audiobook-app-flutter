# Aurora Audio Flutter App

A premium Android audiobook application built in Flutter with dark mode, background playback, media controls, audio focus handling, Hive persistence, Riverpod state management, and modern UI.

## Setup

1. Install Flutter stable locally.
2. Run:
   ```bash
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Android Permissions

- `android.permission.INTERNET`
- `android.permission.FOREGROUND_SERVICE`
- `android.permission.WAKE_LOCK`
- `android.permission.BLUETOOTH`
- `android.permission.BLUETOOTH_CONNECT`
- `android.permission.BLUETOOTH_SCAN`

## Key Architecture

- `lib/src/app.dart` - application entry and GoRouter setup
- `lib/src/routes/app_router.dart` - named route configuration
- `lib/src/theme/app_theme.dart` - Material 3 dark theme using Google Fonts
- `lib/src/providers/app_providers.dart` - Riverpod providers and app state
- `lib/src/services/audio/` - audio handler and service initialization
- `lib/src/data/` - model and mocked data source
- `lib/src/presentation/` - screens and reusable widgets

## Recommended Packages

- `flutter_riverpod`
- `go_router`
- `just_audio`
- `audio_service`
- `audio_session`
- `hive_flutter`
- `cached_network_image`
- `google_fonts`
- `flutter_animate`

## Performance Tips

- Use `const` widgets wherever possible.
- Cache network images with `cached_network_image`.
- Keep audio logic separated from UI through Riverpod and service classes.
- Prefer `const` constructors and avoid rebuilding large lists unnecessarily.
- Move heavy audio preparation to background isolates when real offline downloads are implemented.

## Future Scaling

- Add real backend API integration using `Dio` and repository/use case layers.
- Implement chapter bookmarks and user profiles.
- Add offline download management with actual file persistence.
- Build a full queue manager with persistent playlists.
- Add platform-specific audio service configuration for Android 13+ and iOS media session.
