import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_drawer.dart';
import '../widgets/stat_card.dart';
import '../models/campaign.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome header
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Here\'s what\'s happening with your campaigns today',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),

            // Stats cards
            GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.5,
              children: const [
                StatCard(
                  title: 'Total Contacts',
                  value: '12,543',
                  trend: '+12.5%',
                  trendUp: true,
                  icon: Icons.people_outline,
                  color: Color(0xFF6366F1),
                ),
                StatCard(
                  title: 'Active Campaigns',
                  value: '24',
                  trend: '+5.2%',
                  trendUp: true,
                  icon: Icons.campaign_outlined,
                  color: Color(0xFF8B5CF6),
                ),
                StatCard(
                  title: 'Open Rate',
                  value: '42.3%',
                  trend: '+2.1%',
                  trendUp: true,
                  icon: Icons.mail_outline,
                  color: Color(0xFF10B981),
                ),
                StatCard(
                  title: 'Click Rate',
                  value: '18.7%',
                  trend: '-1.3%',
                  trendUp: false,
                  icon: Icons.touch_app_outlined,
                  color: Color(0xFFF59E0B),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Charts row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email performance chart
                Expanded(
                  flex: 2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email Performance',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 300,
                            child: LineChart(
                              LineChartData(
                                gridData: const FlGridData(show: true),
                                titlesData: const FlTitlesData(show: true),
                                borderData: FlBorderData(show: true),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: const [
                                      FlSpot(0, 3),
                                      FlSpot(1, 4),
                                      FlSpot(2, 3.5),
                                      FlSpot(3, 5),
                                      FlSpot(4, 4.5),
                                      FlSpot(5, 6),
                                      FlSpot(6, 5.5),
                                    ],
                                    isCurved: true,
                                    color: const Color(0xFF6366F1),
                                    barWidth: 3,
                                    dotData: const FlDotData(show: false),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Campaign status
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Campaign Status',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 300,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    value: 40,
                                    title: 'Sent',
                                    color: const Color(0xFF10B981),
                                    radius: 100,
                                  ),
                                  PieChartSectionData(
                                    value: 30,
                                    title: 'Scheduled',
                                    color: const Color(0xFF3B82F6),
                                    radius: 100,
                                  ),
                                  PieChartSectionData(
                                    value: 20,
                                    title: 'Draft',
                                    color: const Color(0xFFF59E0B),
                                    radius: 100,
                                  ),
                                  PieChartSectionData(
                                    value: 10,
                                    title: 'Sending',
                                    color: const Color(0xFF8B5CF6),
                                    radius: 100,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Recent campaigns
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Campaigns',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextButton(
                          onPressed: () => context.go('/campaigns'),
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildRecentCampaignsList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/campaigns/create'),
        icon: const Icon(Icons.add),
        label: const Text('New Campaign'),
      ),
    );
  }

  Widget _buildRecentCampaignsList() {
    return Column(
      children: [
        _buildCampaignRow(
          'Summer Sale Newsletter',
          'Sent',
          '5,432',
          '42.3%',
          CampaignStatus.sent,
        ),
        const Divider(),
        _buildCampaignRow(
          'Product Launch Announcement',
          'Scheduled',
          '8,120',
          '-',
          CampaignStatus.scheduled,
        ),
        const Divider(),
        _buildCampaignRow(
          'Weekly Update',
          'Draft',
          '-',
          '-',
          CampaignStatus.draft,
        ),
      ],
    );
  }

  Widget _buildCampaignRow(
    String name,
    String status,
    String recipients,
    String openRate,
    CampaignStatus statusEnum,
  ) {
    Color statusColor;
    switch (statusEnum) {
      case CampaignStatus.sent:
        statusColor = const Color(0xFF10B981);
        break;
      case CampaignStatus.scheduled:
        statusColor = const Color(0xFF3B82F6);
        break;
      case CampaignStatus.draft:
        statusColor = const Color(0xFF6B7280);
        break;
      default:
        statusColor = const Color(0xFF8B5CF6);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              recipients,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              openRate,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
