# Setup Instructions

## Prerequisites
- Flutter SDK 3.0.0 or higher
- Android Studio or VS Code with Flutter extensions
- Android SDK 21 (Android 5.0) or higher

## Installation Steps

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Generate Hive Adapters**
   The app uses Hive for local storage. You need to generate the type adapters:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Run the App**
   ```bash
   flutter run
   ```

## Important Notes

- The Hive adapters (`.g.dart` files) need to be generated before running the app. These files are auto-generated from the model classes with `@HiveType` annotations.

- For notifications to work properly, make sure to grant notification permissions when prompted.

- The app uses Material Design 3 with dark mode support. Theme preference is saved in SharedPreferences.

## Project Structure

- `lib/models/` - Data models with Hive annotations
- `lib/providers/` - State management using Provider
- `lib/screens/` - UI screens organized by feature
- `lib/services/` - Business logic and services
- `lib/widgets/` - Reusable UI components
- `lib/utils/` - Utilities and constants

## Features Implemented

✅ Daily routine tracking (wake up, sleep, custom routines)
✅ Meal tracking with customizable meal types
✅ Water intake tracking with goals
✅ Self-care routines (hair care, skin care, baths) with customizable steps
✅ Schedule management (job timing, study hours)
✅ Calendar view with monthly/weekly/daily views
✅ Alarms and reminders
✅ Progress tracking with charts and statistics
✅ Dark mode support
✅ Cloud sync and backup (local backup/restore)
✅ Customization screens for routines, meals, and self-care steps

