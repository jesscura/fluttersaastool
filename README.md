# Flutter Email Marketing & CRM Tool

A comprehensive email marketing and CRM tool built with Flutter, featuring functionality similar to MailChimp, Snov.io, and Monday.com.

## Features

### Email Marketing (MailChimp-like)
- ✅ **Campaign Management**: Create, edit, schedule, and send email campaigns
- ✅ **Email Templates**: Pre-built templates with customization options
- ✅ **Contact Segmentation**: Organize contacts into lists and segments
- ✅ **Email Personalization**: Dynamic content with merge tags
- ✅ **Analytics Dashboard**: Track opens, clicks, bounces, and unsubscribes
- ✅ **A/B Testing**: Test different subject lines and content
- ✅ **Automation**: Scheduled campaigns and drip sequences

### Contact Management (Snov.io-like)
- ✅ **Contact Database**: Store and manage unlimited contacts
- ✅ **Email Verification**: Validate email addresses
- ✅ **Import/Export**: CSV and Excel support
- ✅ **Custom Fields**: Add custom data fields to contacts
- ✅ **Tags and Filters**: Organize contacts with tags and advanced filters
- ✅ **Engagement Tracking**: Monitor contact engagement metrics

### CRM Features (Monday.com/Lark-like)
- ✅ **Deal Pipeline**: Visual pipeline for sales tracking
- ✅ **Deal Stages**: Lead, Qualified, Proposal, Negotiation, Won, Lost
- ✅ **Activity Timeline**: Track calls, meetings, emails, and tasks
- ✅ **Task Management**: Create and assign tasks with due dates
- ✅ **Custom Fields**: Flexible data structure for deals
- ✅ **Analytics**: Deal value tracking and win rate statistics

## Technology Stack

- **Framework**: Flutter 3.0+
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **UI Components**: Material Design 3
- **Charts**: FL Chart & Syncfusion Flutter Charts
- **Email**: Mailer package
- **Storage**: SharedPreferences, Hive, SQLite

## Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code
- Xcode (for iOS on macOS)

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/jesscura/fluttersaastool.git
   cd fluttersaastool
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Deployment

### Web
```bash
flutter build web --release
```

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ipa --release
```

## Project Structure

```
lib/
├── main.dart
├── config/
│   ├── theme.dart
│   └── routes.dart
├── models/
├── services/
├── repositories/
├── screens/
└── widgets/
```

## License

MIT License