import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/dashboard_screen.dart';
import '../screens/campaigns/campaigns_screen.dart';
import '../screens/campaigns/campaign_detail_screen.dart';
import '../screens/campaigns/create_campaign_screen.dart';
import '../screens/contacts/contacts_screen.dart';
import '../screens/contacts/contact_detail_screen.dart';
import '../screens/contacts/create_contact_screen.dart';
import '../screens/deals/deals_screen.dart';
import '../screens/deals/deal_detail_screen.dart';
import '../screens/deals/create_deal_screen.dart';
import '../screens/templates/templates_screen.dart';
import '../screens/analytics/analytics_screen.dart';
import '../screens/settings/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => const MaterialPage(
        child: DashboardScreen(),
      ),
    ),
    
    // Campaigns
    GoRoute(
      path: '/campaigns',
      name: 'campaigns',
      pageBuilder: (context, state) => const MaterialPage(
        child: CampaignsScreen(),
      ),
    ),
    GoRoute(
      path: '/campaigns/create',
      name: 'create-campaign',
      pageBuilder: (context, state) => const MaterialPage(
        child: CreateCampaignScreen(),
      ),
    ),
    GoRoute(
      path: '/campaigns/:id',
      name: 'campaign-detail',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return MaterialPage(
          child: CampaignDetailScreen(campaignId: id),
        );
      },
    ),

    // Contacts
    GoRoute(
      path: '/contacts',
      name: 'contacts',
      pageBuilder: (context, state) => const MaterialPage(
        child: ContactsScreen(),
      ),
    ),
    GoRoute(
      path: '/contacts/create',
      name: 'create-contact',
      pageBuilder: (context, state) => const MaterialPage(
        child: CreateContactScreen(),
      ),
    ),
    GoRoute(
      path: '/contacts/:id',
      name: 'contact-detail',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return MaterialPage(
          child: ContactDetailScreen(contactId: id),
        );
      },
    ),

    // Deals (CRM)
    GoRoute(
      path: '/deals',
      name: 'deals',
      pageBuilder: (context, state) => const MaterialPage(
        child: DealsScreen(),
      ),
    ),
    GoRoute(
      path: '/deals/create',
      name: 'create-deal',
      pageBuilder: (context, state) => const MaterialPage(
        child: CreateDealScreen(),
      ),
    ),
    GoRoute(
      path: '/deals/:id',
      name: 'deal-detail',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return MaterialPage(
          child: DealDetailScreen(dealId: id),
        );
      },
    ),

    // Templates
    GoRoute(
      path: '/templates',
      name: 'templates',
      pageBuilder: (context, state) => const MaterialPage(
        child: TemplatesScreen(),
      ),
    ),

    // Analytics
    GoRoute(
      path: '/analytics',
      name: 'analytics',
      pageBuilder: (context, state) => const MaterialPage(
        child: AnalyticsScreen(),
      ),
    ),

    // Settings
    GoRoute(
      path: '/settings',
      name: 'settings',
      pageBuilder: (context, state) => const MaterialPage(
        child: SettingsScreen(),
      ),
    ),
  ],
);
