# Quick Start Guide

Get your Flutter Email Marketing & CRM Tool up and running in minutes!

## Prerequisites

Before you begin, ensure you have:
- ✅ Flutter SDK 3.0+ installed ([Installation Guide](https://docs.flutter.dev/get-started/install))
- ✅ Git installed
- ✅ An IDE (VS Code, Android Studio, or IntelliJ)
- ✅ Flutter and Dart plugins for your IDE

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/jesscura/fluttersaastool.git
cd fluttersaastool
```

### 2. Install Dependencies

```bash
flutter pub get
```

This will download all required packages listed in `pubspec.yaml`.

### 3. Generate Code

Generate the necessary code for JSON serialization:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Run the Application

Choose your platform and run:

```bash
# For web
flutter run -d chrome

# For Android (requires device or emulator)
flutter run -d android

# For iOS (macOS only, requires device or simulator)
flutter run -d ios

# For desktop
flutter run -d windows  # Windows
flutter run -d macos    # macOS
flutter run -d linux    # Linux
```

## First Launch

When you first launch the app, you'll see:

1. **Dashboard**: Overview of your email marketing metrics
2. **Sidebar Navigation**: Access all features from the drawer menu
3. **Sample Data**: The app starts with empty data - begin by adding contacts!

## Your First Campaign

### Step 1: Add Contacts

1. Click the menu icon (☰) in the top left
2. Select **Contacts**
3. Click the **Add Contact** button
4. Fill in the contact details:
   - Email (required)
   - First Name
   - Last Name
   - Company
   - Phone Number
5. Click **Create**

### Step 2: Create a Campaign

1. Go to **Campaigns** from the sidebar
2. Click **New Campaign** button
3. Fill in the campaign details:
   - Campaign Name: "My First Campaign"
   - Email Subject: "Welcome to Our Newsletter!"
   - From Name: Your name or company
   - From Email: your-email@example.com
   - Reply-To: reply@example.com
   - Content: Your email message (supports HTML)
4. Click **Save as Draft** or **Continue**

### Step 3: Explore Templates

1. Go to **Templates** from the sidebar
2. Browse available email templates
3. Click on a template to preview
4. Use templates in your campaigns

### Step 4: Create a Deal

1. Go to **Deals** from the sidebar
2. Click **New Deal** button
3. Fill in:
   - Title: Deal name
   - Value: Deal amount
   - Stage: Current pipeline stage
   - Priority: Deal priority
4. Click **Create**

## Key Features to Try

### 📧 Email Marketing
- Create and send campaigns
- Schedule emails for later
- Use merge tags for personalization: `{{firstName}}`, `{{lastName}}`, etc.
- Track opens and clicks

### 👥 Contact Management
- Import contacts from CSV
- Export your contact list
- Add tags for organization
- Track engagement metrics

### 💼 CRM Pipeline
- Visualize your sales pipeline
- Drag deals between stages
- Add activities and notes
- Track deal values and win rates

### 📊 Analytics
- View campaign performance
- Monitor contact engagement
- Track email metrics
- Generate reports

## Configuration

### Email SMTP Setup (Optional)

To actually send emails, configure SMTP settings in `lib/main.dart`:

```dart
EmailService.instance.configure(
  host: 'smtp.gmail.com',        // Your SMTP host
  port: 587,                      // Port (587 for TLS, 465 for SSL)
  username: 'your-email@gmail.com',
  password: 'your-app-password',  // Use app-specific password
  ssl: true,
);
```

**Gmail Setup:**
1. Enable 2-factor authentication
2. Generate an app-specific password
3. Use that password in the configuration

**Popular SMTP Providers:**
- Gmail: `smtp.gmail.com:587`
- SendGrid: `smtp.sendgrid.net:587`
- Mailgun: `smtp.mailgun.org:587`
- AWS SES: `email-smtp.us-east-1.amazonaws.com:587`

## Troubleshooting

### "Flutter command not found"
```bash
# Make sure Flutter is in your PATH
export PATH="$PATH:/path/to/flutter/bin"
```

### "No devices found"
```bash
# Check available devices
flutter devices

# For web
flutter run -d web-server
```

### Build errors
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Package conflicts
```bash
# Upgrade dependencies
flutter pub upgrade
```

## Development Mode

### Hot Reload

While the app is running:
- Press `r` to hot reload (quick refresh)
- Press `R` to hot restart (full restart)
- Press `q` to quit

### Debug Mode

Enable debug features:
1. Look for the debug banner in the top right
2. Use Flutter DevTools for inspection
3. Check console for debug output

## Next Steps

1. **Read the Documentation**
   - [README.md](README.md) - Overview and features
   - [FEATURES.md](FEATURES.md) - Detailed feature documentation
   - [API.md](API.md) - API reference
   - [DEPLOYMENT.md](DEPLOYMENT.md) - Deployment guides

2. **Customize the App**
   - Modify `lib/config/theme.dart` for styling
   - Update `lib/config/routes.dart` for navigation
   - Add your branding and assets

3. **Deploy Your App**
   - Follow [DEPLOYMENT.md](DEPLOYMENT.md) for platform-specific instructions
   - Build for web, mobile, or desktop

4. **Contribute**
   - Read [CONTRIBUTING.md](CONTRIBUTING.md)
   - Report bugs or request features
   - Submit pull requests

## Tips & Tricks

💡 **Use Merge Tags**: Personalize emails with `{{firstName}}`, `{{lastName}}`, `{{company}}`

💡 **Tag Organization**: Use tags to organize contacts and campaigns

💡 **Pipeline Management**: Drag deals between stages in the pipeline view

💡 **Keyboard Shortcuts**: 
- `Ctrl/Cmd + S` to save
- `Esc` to close dialogs
- `Tab` to navigate forms

💡 **Mobile Testing**: Test on mobile devices for responsive design

## Support & Community

- 📧 **Email**: support@example.com
- 💬 **Issues**: [GitHub Issues](https://github.com/jesscura/fluttersaastool/issues)
- 📚 **Documentation**: [Wiki](https://github.com/jesscura/fluttersaastool/wiki)
- 🐦 **Twitter**: @yourhandle

## What's Next?

Check out our advanced features:
- Email automation workflows
- A/B testing campaigns
- Advanced segmentation
- API integrations
- Team collaboration

---

**Need help?** Open an issue on GitHub or check the documentation!

Happy emailing! 🚀
