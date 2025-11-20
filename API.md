# API Documentation

## Overview

This document describes the internal API structure of the Flutter Email Marketing & CRM Tool. This can be used as a reference for extending functionality or integrating with backend services.

## Services

### EmailService

Handles all email-related operations including sending campaigns and individual emails.

```dart
import 'package:flutter_saas_tool/services/email_service.dart';

// Configure SMTP
EmailService.instance.configure(
  host: 'smtp.example.com',
  port: 587,
  username: 'user@example.com',
  password: 'password',
  ssl: true,
);

// Send single email
await EmailService.instance.sendEmail(
  to: 'recipient@example.com',
  from: 'sender@example.com',
  fromName: 'Sender Name',
  subject: 'Email Subject',
  htmlBody: '<h1>Email Content</h1>',
  textBody: 'Email Content',
  replyTo: 'reply@example.com',
);

// Send campaign
final result = await EmailService.instance.sendCampaign(
  campaign: campaign,
  recipients: contacts,
  onProgress: (sent, total) {
    print('Sent $sent of $total');
  },
);

// Validate email
bool isValid = EmailService.instance.isValidEmail('test@example.com');

// Verify email domain
bool isDomainValid = await EmailService.instance.verifyEmailDomain('test@example.com');
```

### AnalyticsService

Tracks and calculates analytics metrics.

```dart
import 'package:flutter_saas_tool/services/analytics_service.dart';

// Track email open
await AnalyticsService.instance.trackEmailOpen(
  campaignId: 'campaign123',
  contactId: 'contact456',
);

// Track email click
await AnalyticsService.instance.trackEmailClick(
  campaignId: 'campaign123',
  contactId: 'contact456',
  linkUrl: 'https://example.com',
);

// Calculate campaign stats
final stats = AnalyticsService.instance.calculateCampaignStats(
  totalRecipients: 1000,
  sent: 990,
  delivered: 980,
  opened: 420,
  clicked: 180,
  bounced: 10,
  unsubscribed: 5,
  complained: 2,
);

// Calculate engagement score
double score = AnalyticsService.instance.calculateEngagementScore(contact);

// Get dashboard metrics
final metrics = await AnalyticsService.instance.getDashboardMetrics(
  campaigns: campaigns,
  contacts: contacts,
);
```

### StorageService

Manages local data persistence.

```dart
import 'package:flutter_saas_tool/services/storage_service.dart';

// Initialize (called in main.dart)
await StorageService.instance.init();

// Theme
await StorageService.instance.setThemeMode('dark');
String? theme = StorageService.instance.getThemeMode();

// Authentication
await StorageService.instance.setAuthToken('token123');
String? token = StorageService.instance.getAuthToken();
await StorageService.instance.clearAuthToken();

// User data
await StorageService.instance.setUserId('user123');
await StorageService.instance.setUserEmail('user@example.com');
String? userId = StorageService.instance.getUserId();
String? email = StorageService.instance.getUserEmail();

// Clear all data
await StorageService.instance.clearAll();
```

## Repositories

### CampaignRepository

Manages campaign data and operations.

```dart
import 'package:flutter_saas_tool/repositories/campaign_repository.dart';

final repo = CampaignRepository.instance;

// Get campaigns
List<Campaign> campaigns = await repo.getCampaigns();
List<Campaign> drafts = await repo.getCampaigns(status: CampaignStatus.draft);
List<Campaign> searchResults = await repo.getCampaigns(search: 'newsletter');

// Get campaign by ID
Campaign? campaign = await repo.getCampaignById('campaign123');

// Create campaign
Campaign newCampaign = await repo.createCampaign(
  name: 'Summer Sale',
  subject: 'Check out our summer deals!',
  fromName: 'Company Name',
  fromEmail: 'hello@company.com',
  replyTo: 'support@company.com',
  content: '<h1>Summer Sale</h1>',
  recipientListIds: ['list1', 'list2'],
);

// Update campaign
Campaign updated = await repo.updateCampaign(campaign.copyWith(
  subject: 'New Subject',
));

// Delete campaign
await repo.deleteCampaign('campaign123');

// Schedule campaign
Campaign scheduled = await repo.scheduleCampaign(
  'campaign123',
  DateTime.now().add(Duration(hours: 24)),
);

// Send campaign
Campaign sending = await repo.sendCampaign('campaign123');

// Mark as sent
Campaign sent = await repo.markAsSent('campaign123', stats);

// Get statistics
Map<String, dynamic> stats = await repo.getStatistics();
```

### ContactRepository

Manages contact data and operations.

```dart
import 'package:flutter_saas_tool/repositories/contact_repository.dart';

final repo = ContactRepository.instance;

// Get contacts
List<Contact> contacts = await repo.getContacts();
List<Contact> active = await repo.getContacts(status: ContactStatus.active);
List<Contact> tagged = await repo.getContacts(tags: ['customer', 'vip']);
List<Contact> searchResults = await repo.getContacts(search: 'john');

// Get contact by ID or email
Contact? contact = await repo.getContactById('contact123');
Contact? contactByEmail = await repo.getContactByEmail('john@example.com');

// Create contact
Contact newContact = await repo.createContact(
  email: 'john@example.com',
  firstName: 'John',
  lastName: 'Doe',
  company: 'Example Corp',
  phoneNumber: '+1234567890',
  tags: ['customer'],
  customFields: {'source': 'website'},
);

// Update contact
Contact updated = await repo.updateContact(contact.copyWith(
  firstName: 'Jane',
));

// Delete contact
await repo.deleteContact('contact123');

// Import contacts
Map<String, dynamic> result = await repo.importContacts([
  {'email': 'user1@example.com', 'firstName': 'User', 'lastName': 'One'},
  {'email': 'user2@example.com', 'firstName': 'User', 'lastName': 'Two'},
]);
// Returns: {added: 2, updated: 0, skipped: 0, errors: []}

// Export contacts
List<Map<String, dynamic>> exported = await repo.exportContacts();

// Tag management
Contact tagged = await repo.addTag('contact123', 'vip');
Contact untagged = await repo.removeTag('contact123', 'vip');

// Get statistics
Map<String, dynamic> stats = await repo.getStatistics();
```

### DealRepository

Manages CRM deal data and operations.

```dart
import 'package:flutter_saas_tool/repositories/deal_repository.dart';

final repo = DealRepository.instance;

// Get deals
List<Deal> deals = await repo.getDeals();
List<Deal> qualified = await repo.getDeals(stage: DealStage.qualified);
List<Deal> high = await repo.getDeals(priority: DealPriority.high);
List<Deal> assigned = await repo.getDeals(assignedTo: 'user123');

// Get deal by ID
Deal? deal = await repo.getDealById('deal123');

// Create deal
Deal newDeal = await repo.createDeal(
  title: 'Big Client Deal',
  description: 'Potential 50k deal',
  value: 50000.0,
  currency: 'USD',
  stage: DealStage.lead,
  priority: DealPriority.high,
  contactId: 'contact123',
  assignedTo: 'user123',
  expectedCloseDate: DateTime.now().add(Duration(days: 30)),
);

// Update deal
Deal updated = await repo.updateDeal(deal.copyWith(
  value: 55000.0,
));

// Delete deal
await repo.deleteDeal('deal123');

// Move to stage
Deal moved = await repo.moveDealToStage('deal123', DealStage.proposal);

// Add activity
Deal withActivity = await repo.addActivity(
  dealId: 'deal123',
  type: ActivityType.call,
  title: 'Follow-up call',
  description: 'Discussed pricing',
  dueDate: DateTime.now().add(Duration(days: 7)),
  createdBy: 'user123',
);

// Complete activity
Deal completed = await repo.completeActivity('deal123', 'activity123');

// Get deals by stage (for pipeline view)
Map<DealStage, List<Deal>> pipeline = await repo.getDealsByStage();

// Get statistics
Map<String, dynamic> stats = await repo.getStatistics();
// Returns: {total, totalValue, won, wonValue, lost, winRate}
```

## Models

### Campaign

```dart
class Campaign {
  final String id;
  final String name;
  final String subject;
  final String previewText;
  final String fromName;
  final String fromEmail;
  final String replyTo;
  final String content;
  final String? templateId;
  final CampaignStatus status;
  final CampaignType type;
  final DateTime createdAt;
  final DateTime? scheduledAt;
  final DateTime? sentAt;
  final List<String> recipientListIds;
  final List<String> tags;
  final CampaignStats stats;
  final Map<String, dynamic> settings;
}

enum CampaignStatus {
  draft,
  scheduled,
  sending,
  sent,
  paused,
  cancelled,
}

enum CampaignType {
  regular,
  automated,
  abTest,
  rss,
}
```

### Contact

```dart
class Contact {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? phoneNumber;
  final List<String> tags;
  final Map<String, dynamic> customFields;
  final ContactStatus status;
  final DateTime createdAt;
  final DateTime? lastEmailedAt;
  final int emailsSent;
  final int emailsOpened;
  final int emailsClicked;
  final bool isVerified;
  final String? verificationStatus;
}

enum ContactStatus {
  active,
  unsubscribed,
  bounced,
  complained,
}
```

### Deal

```dart
class Deal {
  final String id;
  final String title;
  final String? description;
  final double value;
  final String currency;
  final DealStage stage;
  final DealPriority priority;
  final String? contactId;
  final String? assignedTo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? expectedCloseDate;
  final DateTime? closedAt;
  final List<String> tags;
  final Map<String, dynamic> customFields;
  final List<Activity> activities;
}

enum DealStage {
  lead,
  qualified,
  proposal,
  negotiation,
  won,
  lost,
}

enum DealPriority {
  low,
  medium,
  high,
  urgent,
}

class Activity {
  final String id;
  final String dealId;
  final ActivityType type;
  final String title;
  final String? description;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime? dueDate;
  final bool isCompleted;
}

enum ActivityType {
  call,
  meeting,
  email,
  task,
  note,
}
```

## Navigation

Routes are defined in `lib/config/routes.dart` using GoRouter:

```dart
// Navigate to screens
context.go('/');                          // Dashboard
context.go('/campaigns');                 // Campaigns list
context.go('/campaigns/create');          // Create campaign
context.go('/campaigns/123');             // Campaign detail
context.go('/contacts');                  // Contacts list
context.go('/contacts/create');           // Create contact
context.go('/contacts/123');              // Contact detail
context.go('/deals');                     // Deals pipeline
context.go('/deals/create');              // Create deal
context.go('/deals/123');                 // Deal detail
context.go('/templates');                 // Email templates
context.go('/analytics');                 // Analytics
context.go('/settings');                  // Settings
```

## Theming

Access theme colors and styles from `lib/config/theme.dart`:

```dart
// Colors
AppTheme.primaryColor      // #6366F1 (Indigo)
AppTheme.secondaryColor    // #8B5CF6 (Purple)
AppTheme.successColor      // #10B981 (Green)
AppTheme.warningColor      // #F59E0B (Amber)
AppTheme.errorColor        // #EF4444 (Red)
AppTheme.infoColor         // #3B82F6 (Blue)

// Themes
AppTheme.lightTheme
AppTheme.darkTheme
```

## Error Handling

All repository methods may throw exceptions. Wrap calls in try-catch:

```dart
try {
  final campaign = await CampaignRepository.instance.createCampaign(
    // parameters
  );
} catch (e) {
  print('Error creating campaign: $e');
  // Handle error
}
```

## Best Practices

1. **Use Singletons**: All services and repositories use singleton pattern
2. **Async/Await**: All data operations are asynchronous
3. **Immutable Models**: Use `copyWith` to update models
4. **Error Handling**: Always handle potential errors
5. **Validation**: Validate user input before saving
6. **Type Safety**: Use enums for status fields
7. **Documentation**: Document custom fields and settings

## Future Backend Integration

To integrate with a REST API backend:

1. Replace repository implementations with API calls
2. Add authentication headers to requests
3. Handle network errors and timeouts
4. Implement caching strategy
5. Add offline support with sync

Example API service structure:

```dart
class ApiService {
  static final instance = ApiService._internal();
  ApiService._internal();
  
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.example.com',
    headers: {'Authorization': 'Bearer ${token}'},
  ));
  
  Future<Campaign> createCampaign(Campaign campaign) async {
    final response = await dio.post('/campaigns', data: campaign.toJson());
    return Campaign.fromJson(response.data);
  }
}
```
