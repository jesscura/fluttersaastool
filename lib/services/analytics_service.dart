import '../models/campaign.dart';
import '../models/contact.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  static AnalyticsService get instance => _instance;
  
  AnalyticsService._internal();

  /// Track email open
  Future<void> trackEmailOpen({
    required String campaignId,
    required String contactId,
  }) async {
    // In production, this would send data to analytics backend
    print('Email opened: Campaign $campaignId, Contact $contactId');
  }

  /// Track email click
  Future<void> trackEmailClick({
    required String campaignId,
    required String contactId,
    required String linkUrl,
  }) async {
    // In production, this would send data to analytics backend
    print('Link clicked: Campaign $campaignId, Contact $contactId, URL $linkUrl');
  }

  /// Calculate campaign statistics
  CampaignStats calculateCampaignStats({
    required int totalRecipients,
    required int sent,
    required int delivered,
    required int opened,
    required int clicked,
    required int bounced,
    required int unsubscribed,
    required int complained,
  }) {
    final openRate = delivered > 0 ? (opened / delivered) * 100 : 0.0;
    final clickRate = delivered > 0 ? (clicked / delivered) * 100 : 0.0;
    final bounceRate = sent > 0 ? (bounced / sent) * 100 : 0.0;

    return CampaignStats(
      totalRecipients: totalRecipients,
      sent: sent,
      delivered: delivered,
      opened: opened,
      clicked: clicked,
      bounced: bounced,
      unsubscribed: unsubscribed,
      complained: complained,
      openRate: double.parse(openRate.toStringAsFixed(2)),
      clickRate: double.parse(clickRate.toStringAsFixed(2)),
      bounceRate: double.parse(bounceRate.toStringAsFixed(2)),
    );
  }

  /// Get contact engagement score
  double calculateEngagementScore(Contact contact) {
    if (contact.emailsSent == 0) return 0.0;

    final openRate = contact.emailsOpened / contact.emailsSent;
    final clickRate = contact.emailsClicked / contact.emailsSent;

    // Weighted score: 40% opens, 60% clicks
    final score = (openRate * 0.4 + clickRate * 0.6) * 100;
    return double.parse(score.toStringAsFixed(2));
  }

  /// Get dashboard metrics
  Future<Map<String, dynamic>> getDashboardMetrics({
    required List<Campaign> campaigns,
    required List<Contact> contacts,
  }) async {
    final totalCampaigns = campaigns.length;
    final activeCampaigns = campaigns.where((c) => 
      c.status == CampaignStatus.sending || c.status == CampaignStatus.scheduled
    ).length;
    
    final totalContacts = contacts.length;
    final activeContacts = contacts.where((c) => 
      c.status == ContactStatus.active
    ).length;

    final totalEmailsSent = campaigns
        .map((c) => c.stats.sent)
        .fold(0, (sum, count) => sum + count);

    final totalEmailsOpened = campaigns
        .map((c) => c.stats.opened)
        .fold(0, (sum, count) => sum + count);

    final averageOpenRate = totalEmailsSent > 0
        ? (totalEmailsOpened / totalEmailsSent) * 100
        : 0.0;

    return {
      'totalCampaigns': totalCampaigns,
      'activeCampaigns': activeCampaigns,
      'totalContacts': totalContacts,
      'activeContacts': activeContacts,
      'totalEmailsSent': totalEmailsSent,
      'totalEmailsOpened': totalEmailsOpened,
      'averageOpenRate': double.parse(averageOpenRate.toStringAsFixed(2)),
    };
  }
}
