#!/bin/bash
# Local development start script

set -e

echo "🚀 Starting Flutter SaaS Tool setup..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "Visit: https://docs.flutter.dev/get-started/install"
    exit 1
fi

echo "✓ Flutter found: $(flutter --version | head -n 1)"

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Generate code if build_runner is configured
if grep -q "build_runner" pubspec.yaml; then
    echo "🔨 Running build_runner..."
    flutter pub run build_runner build --delete-conflicting-outputs
fi

# Run the app
echo "🎯 Starting Flutter web app..."
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0

echo "✅ App should be available at http://localhost:8080"
