# Contributing to Flutter Email Marketing & CRM Tool

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on the best outcome for the community
- Show empathy towards other contributors

## Getting Started

1. **Fork the repository**
   ```bash
   git clone https://github.com/jesscura/fluttersaastool.git
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Guidelines

### Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter analyze` to check for issues
- Format code with `dart format .`
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

### Naming Conventions

- **Files**: lowercase_with_underscores.dart
- **Classes**: PascalCase
- **Variables/Functions**: camelCase
- **Constants**: camelCase with const keyword
- **Private members**: _leadingUnderscore

### Project Structure

```
lib/
├── config/          # App configuration
├── models/          # Data models
├── services/        # Business logic
├── repositories/    # Data layer
├── screens/         # UI screens
├── widgets/         # Reusable widgets
└── utils/           # Helper functions
```

### Adding New Features

1. **Models**: Add to `lib/models/`
   - Include JSON serialization
   - Add to/from JSON methods
   - Use immutable classes
   - Include copyWith method

2. **Services**: Add to `lib/services/`
   - Use singleton pattern
   - Document public methods
   - Handle errors gracefully

3. **Repositories**: Add to `lib/repositories/`
   - Follow existing patterns
   - Return Future for async operations
   - Include error handling

4. **Screens**: Add to `lib/screens/`
   - Use StatelessWidget when possible
   - Extract reusable widgets
   - Follow Material Design guidelines

5. **Routes**: Update `lib/config/routes.dart`
   - Add new routes to GoRouter
   - Use named routes
   - Include parameter validation

### Testing

Write tests for new features:

```dart
// test/models/campaign_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_saas_tool/models/campaign.dart';

void main() {
  group('Campaign', () {
    test('creates campaign correctly', () {
      final campaign = Campaign(
        id: '123',
        name: 'Test Campaign',
        // ... other required fields
      );
      
      expect(campaign.name, 'Test Campaign');
    });
    
    test('copyWith works correctly', () {
      final campaign = Campaign(/* ... */);
      final updated = campaign.copyWith(name: 'New Name');
      
      expect(updated.name, 'New Name');
      expect(updated.id, campaign.id);
    });
  });
}
```

Run tests:
```bash
flutter test
```

### Documentation

- Add dartdoc comments to public APIs
- Update README.md for major features
- Update API.md for API changes
- Add examples for complex features

Example:
```dart
/// Sends an email campaign to multiple recipients.
///
/// The [campaign] contains the email content and settings.
/// The [recipients] list contains all contacts to send to.
/// The [onProgress] callback is called with current progress.
///
/// Returns a map with send statistics including:
/// - `sent`: Number of successfully sent emails
/// - `failed`: Number of failed sends
/// - `errors`: Map of email to error message
///
/// Example:
/// ```dart
/// final result = await sendCampaign(
///   campaign: myCampaign,
///   recipients: contacts,
///   onProgress: (sent, total) => print('$sent/$total'),
/// );
/// print('Sent ${result['sent']} emails');
/// ```
Future<Map<String, dynamic>> sendCampaign({
  required Campaign campaign,
  required List<Contact> recipients,
  Function(int sent, int total)? onProgress,
}) async {
  // implementation
}
```

## Submitting Changes

1. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add new feature"
   ```

2. **Follow commit message conventions**
   - `feat:` New feature
   - `fix:` Bug fix
   - `docs:` Documentation changes
   - `style:` Code style changes (formatting)
   - `refactor:` Code refactoring
   - `test:` Adding tests
   - `chore:` Maintenance tasks

3. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

4. **Create a Pull Request**
   - Provide a clear description
   - Reference related issues
   - Include screenshots for UI changes
   - Ensure all tests pass
   - Update documentation

## Pull Request Checklist

- [ ] Code follows project style guidelines
- [ ] Changes are tested
- [ ] Documentation is updated
- [ ] Commit messages follow conventions
- [ ] No merge conflicts
- [ ] All CI checks pass

## Bug Reports

When reporting bugs, include:

1. **Description**: Clear description of the issue
2. **Steps to Reproduce**: Detailed steps
3. **Expected Behavior**: What should happen
4. **Actual Behavior**: What actually happens
5. **Environment**:
   - Flutter version
   - Dart version
   - Platform (iOS, Android, Web)
   - Device/Browser

## Feature Requests

When requesting features:

1. **Use Case**: Describe the use case
2. **Proposed Solution**: Your suggested approach
3. **Alternatives**: Other approaches considered
4. **Examples**: Similar features in other apps

## Development Tips

### Hot Reload

Use hot reload during development:
```bash
flutter run
# Press 'r' to hot reload
# Press 'R' to hot restart
```

### Debugging

- Use `debugPrint()` for console output
- Use Flutter DevTools for inspection
- Add breakpoints in VS Code/Android Studio
- Use `flutter analyze` regularly

### Performance

- Profile app performance with DevTools
- Avoid rebuilding entire widget trees
- Use `const` constructors where possible
- Lazy load large lists
- Optimize images and assets

### Common Issues

**Problem**: Build runner not generating files
```bash
# Solution
flutter pub run build_runner build --delete-conflicting-outputs
```

**Problem**: Dependencies conflict
```bash
# Solution
flutter pub upgrade
flutter clean
flutter pub get
```

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design Guidelines](https://material.io/design)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

## Questions?

- Open an issue for questions
- Check existing issues first
- Be specific and provide context

Thank you for contributing! 🎉
