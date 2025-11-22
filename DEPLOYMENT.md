# Deployment Guide

This guide covers deploying the Flutter Email Marketing & CRM Tool to various platforms.

## Prerequisites

- Flutter SDK installed and configured
- All dependencies installed (`flutter pub get`)
- Generated code up to date (`flutter pub run build_runner build`)

## Web Deployment

### Build for Web

```bash
flutter build web --release
```

The output will be in `build/web/`.

### Deploy to Firebase Hosting

1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Login to Firebase:
   ```bash
   firebase login
   ```

3. Initialize Firebase:
   ```bash
   firebase init hosting
   ```

4. Configure `firebase.json`:
   ```json
   {
     "hosting": {
       "public": "build/web",
       "ignore": [
         "firebase.json",
         "**/.*",
         "**/node_modules/**"
       ],
       "rewrites": [
         {
           "source": "**",
           "destination": "/index.html"
         }
       ]
     }
   }
   ```

5. Deploy:
   ```bash
   firebase deploy
   ```

### Deploy to Netlify

1. Build the web app:
   ```bash
   flutter build web --release
   ```

2. Install Netlify CLI:
   ```bash
   npm install -g netlify-cli
   ```

3. Deploy:
   ```bash
   netlify deploy --dir=build/web --prod
   ```

### Deploy to Vercel

1. Install Vercel CLI:
   ```bash
   npm install -g vercel
   ```

2. Deploy:
   ```bash
   vercel --prod
   ```

3. Configure `vercel.json`:
   ```json
   {
     "buildCommand": "flutter build web --release",
     "outputDirectory": "build/web",
     "devCommand": "flutter run -d web-server --web-port 3000"
   }
   ```

### Deploy to Railway

Railway provides a simple deployment platform with built-in CI/CD and automatic HTTPS.

See [RAILWAY.md](./RAILWAY.md) for detailed Railway deployment instructions.

**Quick Start:**

1. Sign in to [Railway](https://railway.app/)
2. Create a new project from GitHub repository
3. Select `jesscura/fluttersaastool`
4. Railway automatically detects the `Dockerfile` and deploys
5. Access your app at the provided Railway URL

**Features:**
- ✅ Automatic HTTPS and SSL certificates
- ✅ Built-in CI/CD from GitHub
- ✅ Custom domain support
- ✅ Environment variable management
- ✅ Real-time logs and monitoring
- ✅ Free tier available ($5 credit per month)

## Android Deployment

### 1. Generate Signing Key

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
  -keysize 2048 -validity 10000 -alias upload
```

### 2. Configure Signing

Create `android/key.properties`:

```properties
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=upload
storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks>
```

### 3. Configure Build

Edit `android/app/build.gradle`:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### 4. Build Release APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### 5. Build App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### 6. Upload to Google Play Console

1. Go to [Google Play Console](https://play.google.com/console)
2. Create a new app or select existing
3. Upload the `.aab` file
4. Fill in store listing details
5. Submit for review

## iOS Deployment

### 1. Prerequisites

- macOS with Xcode installed
- Apple Developer Account ($99/year)
- Device registered in Apple Developer Portal

### 2. Configure Signing

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select "Runner" project
3. Go to "Signing & Capabilities"
4. Select your team
5. Set bundle identifier (e.g., `com.yourcompany.fluttersaastool`)

### 3. Configure Info.plist

Edit `ios/Runner/Info.plist` with required permissions:

```xml
<key>NSCameraUsageDescription</key>
<string>This app requires camera access to upload images.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app requires photo library access to upload images.</string>
```

### 4. Build for Release

```bash
flutter build ios --release
```

### 5. Create Archive in Xcode

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select "Any iOS Device" as target
3. Product > Archive
4. Wait for archive to complete

### 6. Upload to App Store Connect

1. In Organizer window, select your archive
2. Click "Distribute App"
3. Select "App Store Connect"
4. Follow the wizard
5. Submit for review in App Store Connect

## Desktop Deployment

### Windows

```bash
flutter build windows --release
```

Output: `build/windows/runner/Release/`

Create installer using:
- Inno Setup
- NSIS
- MSI

### macOS

```bash
flutter build macos --release
```

Output: `build/macos/Build/Products/Release/`

Create DMG installer:
```bash
create-dmg 'build/macos/Build/Products/Release/flutter_saas_tool.app' \
  'build/macos/'
```

### Linux

```bash
flutter build linux --release
```

Output: `build/linux/x64/release/bundle/`

Create .deb package or AppImage for distribution.

## Environment Configuration

### Production Environment Variables

Create `.env.production`:

```env
API_URL=https://api.yourdomain.com
SMTP_HOST=smtp.sendgrid.net
SMTP_PORT=587
APP_NAME=Email Marketing Tool
```

### Load Environment Variables

Use `flutter_dotenv` package:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

await dotenv.load(fileName: ".env.production");
String apiUrl = dotenv.env['API_URL'] ?? 'https://default.com';
```

## CI/CD Setup

### GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy

on:
  push:
    branches: [ main ]

jobs:
  deploy-web:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: flutter pub get
      - run: flutter build web --release
      - uses: FirebaseExtended/action-hosting-deploy@v0
        with:
          repoToken: '${{ secrets.GITHUB_TOKEN }}'
          firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT }}'
          channelId: live
          projectId: your-project-id

  deploy-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter build appbundle --release
      - uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.SERVICE_ACCOUNT_JSON }}
          packageName: com.yourcompany.fluttersaastool
          releaseFiles: build/app/outputs/bundle/release/app-release.aab
          track: production
```

## Performance Optimization

### Web Optimization

1. Enable CanvasKit for better rendering:
   ```bash
   flutter build web --release --web-renderer canvaskit
   ```

2. Use HTML renderer for better load times:
   ```bash
   flutter build web --release --web-renderer html
   ```

3. Enable code splitting:
   ```bash
   flutter build web --release --split-per-abi
   ```

### Mobile Optimization

1. Enable obfuscation:
   ```bash
   flutter build apk --release --obfuscate --split-debug-info=/<project-name>/<directory>
   ```

2. Reduce APK size with ProGuard (Android)
3. Optimize images and assets
4. Use cached network images

## Monitoring and Analytics

### Sentry for Error Tracking

```dart
import 'package:sentry_flutter/sentry_flutter.dart';

await SentryFlutter.init(
  (options) {
    options.dsn = 'your-sentry-dsn';
  },
  appRunner: () => runApp(MyApp()),
);
```

### Firebase Analytics

```dart
import 'package:firebase_analytics/firebase_analytics.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;
await analytics.logEvent(
  name: 'campaign_created',
  parameters: {'campaign_id': '123'},
);
```

## Rollback Strategy

1. Keep previous builds archived
2. Use feature flags for gradual rollout
3. Monitor error rates after deployment
4. Have rollback procedures documented

## Support

For deployment issues:
- Check Flutter documentation: https://docs.flutter.dev/deployment
- GitHub Issues: https://github.com/jesscura/fluttersaastool/issues
- Stack Overflow: Tag with `flutter` and `flutter-deployment`
