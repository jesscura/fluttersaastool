import 'package:uuid/uuid.dart';
import '../models/campaign.dart';

class CampaignRepository {
  static final CampaignRepository _instance = CampaignRepository._internal();
  static CampaignRepository get instance => _instance;
  
  CampaignRepository._internal();

  final _uuid = const Uuid();
  final List<Campaign> _campaigns = [];

  /// Get all campaigns
  Future<List<Campaign>> getCampaigns({
    CampaignStatus? status,
    String? search,
  }) async {
    var campaigns = List<Campaign>.from(_campaigns);

    if (status != null) {
      campaigns = campaigns.where((c) => c.status == status).toList();
    }

    if (search != null && search.isNotEmpty) {
      campaigns = campaigns.where((c) =>
        c.name.toLowerCase().contains(search.toLowerCase()) ||
        c.subject.toLowerCase().contains(search.toLowerCase())
      ).toList();
    }

    return campaigns;
  }

  /// Get campaign by ID
  Future<Campaign?> getCampaignById(String id) async {
    try {
      return _campaigns.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Create new campaign
  Future<Campaign> createCampaign({
    required String name,
    required String subject,
    required String fromName,
    required String fromEmail,
    required String replyTo,
    required String content,
    String? templateId,
    List<String> recipientListIds = const [],
  }) async {
    final now = DateTime.now();
    final campaign = Campaign(
      id: _uuid.v4(),
      name: name,
      subject: subject,
      fromName: fromName,
      fromEmail: fromEmail,
      replyTo: replyTo,
      content: content,
      templateId: templateId,
      recipientListIds: recipientListIds,
      createdAt: now,
    );

    _campaigns.add(campaign);
    return campaign;
  }

  /// Update campaign
  Future<Campaign> updateCampaign(Campaign campaign) async {
    final index = _campaigns.indexWhere((c) => c.id == campaign.id);
    if (index != -1) {
      _campaigns[index] = campaign;
      return campaign;
    }
    throw Exception('Campaign not found');
  }

  /// Delete campaign
  Future<void> deleteCampaign(String id) async {
    _campaigns.removeWhere((c) => c.id == id);
  }

  /// Schedule campaign
  Future<Campaign> scheduleCampaign(String id, DateTime scheduledAt) async {
    final campaign = await getCampaignById(id);
    if (campaign == null) {
      throw Exception('Campaign not found');
    }

    final updated = campaign.copyWith(
      status: CampaignStatus.scheduled,
      scheduledAt: scheduledAt,
    );

    return updateCampaign(updated);
  }

  /// Send campaign
  Future<Campaign> sendCampaign(String id) async {
    final campaign = await getCampaignById(id);
    if (campaign == null) {
      throw Exception('Campaign not found');
    }

    final updated = campaign.copyWith(
      status: CampaignStatus.sending,
    );

    return updateCampaign(updated);
  }

  /// Mark campaign as sent
  Future<Campaign> markAsSent(String id, CampaignStats stats) async {
    final campaign = await getCampaignById(id);
    if (campaign == null) {
      throw Exception('Campaign not found');
    }

    final updated = campaign.copyWith(
      status: CampaignStatus.sent,
      sentAt: DateTime.now(),
      stats: stats,
    );

    return updateCampaign(updated);
  }

  /// Get campaign statistics
  Future<Map<String, dynamic>> getStatistics() async {
    final total = _campaigns.length;
    final draft = _campaigns.where((c) => c.status == CampaignStatus.draft).length;
    final scheduled = _campaigns.where((c) => c.status == CampaignStatus.scheduled).length;
    final sent = _campaigns.where((c) => c.status == CampaignStatus.sent).length;

    return {
      'total': total,
      'draft': draft,
      'scheduled': scheduled,
      'sent': sent,
    };
  }
}
