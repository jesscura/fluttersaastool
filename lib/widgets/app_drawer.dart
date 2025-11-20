import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.email_outlined,
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Text(
                  'Email Marketing',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                Text(
                  'Professional CRM Suite',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Dashboard'),
            onTap: () => context.go('/'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.campaign_outlined),
            title: const Text('Campaigns'),
            onTap: () => context.go('/campaigns'),
          ),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Contacts'),
            onTap: () => context.go('/contacts'),
          ),
          ListTile(
            leading: const Icon(Icons.business_center_outlined),
            title: const Text('Deals'),
            onTap: () => context.go('/deals'),
          ),
          ListTile(
            leading: const Icon(Icons.layers_outlined),
            title: const Text('Templates'),
            onTap: () => context.go('/templates'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.analytics_outlined),
            title: const Text('Analytics'),
            onTap: () => context.go('/analytics'),
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () => context.go('/settings'),
          ),
        ],
      ),
    );
  }
}
