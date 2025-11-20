import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign extends Equatable {
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

  const Campaign({
    required this.id,
    required this.name,
    required this.subject,
    this.previewText = '',
    required this.fromName,
    required this.fromEmail,
    required this.replyTo,
    required this.content,
    this.templateId,
    this.status = CampaignStatus.draft,
    this.type = CampaignType.regular,
    required this.createdAt,
    this.scheduledAt,
    this.sentAt,
    this.recipientListIds = const [],
    this.tags = const [],
    this.stats = const CampaignStats(),
    this.settings = const {},
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => _$CampaignFromJson(json);
  Map<String, dynamic> toJson() => _$CampaignToJson(this);

  Campaign copyWith({
    String? id,
    String? name,
    String? subject,
    String? previewText,
    String? fromName,
    String? fromEmail,
    String? replyTo,
    String? content,
    String? templateId,
    CampaignStatus? status,
    CampaignType? type,
    DateTime? createdAt,
    DateTime? scheduledAt,
    DateTime? sentAt,
    List<String>? recipientListIds,
    List<String>? tags,
    CampaignStats? stats,
    Map<String, dynamic>? settings,
  }) {
    return Campaign(
      id: id ?? this.id,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      previewText: previewText ?? this.previewText,
      fromName: fromName ?? this.fromName,
      fromEmail: fromEmail ?? this.fromEmail,
      replyTo: replyTo ?? this.replyTo,
      content: content ?? this.content,
      templateId: templateId ?? this.templateId,
      status: status ?? this.status,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      sentAt: sentAt ?? this.sentAt,
      recipientListIds: recipientListIds ?? this.recipientListIds,
      tags: tags ?? this.tags,
      stats: stats ?? this.stats,
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        subject,
        previewText,
        fromName,
        fromEmail,
        replyTo,
        content,
        templateId,
        status,
        type,
        createdAt,
        scheduledAt,
        sentAt,
        recipientListIds,
        tags,
        stats,
        settings,
      ];
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

@JsonSerializable()
class CampaignStats extends Equatable {
  final int totalRecipients;
  final int sent;
  final int delivered;
  final int opened;
  final int clicked;
  final int bounced;
  final int unsubscribed;
  final int complained;
  final double openRate;
  final double clickRate;
  final double bounceRate;

  const CampaignStats({
    this.totalRecipients = 0,
    this.sent = 0,
    this.delivered = 0,
    this.opened = 0,
    this.clicked = 0,
    this.bounced = 0,
    this.unsubscribed = 0,
    this.complained = 0,
    this.openRate = 0.0,
    this.clickRate = 0.0,
    this.bounceRate = 0.0,
  });

  factory CampaignStats.fromJson(Map<String, dynamic> json) => _$CampaignStatsFromJson(json);
  Map<String, dynamic> toJson() => _$CampaignStatsToJson(this);

  @override
  List<Object?> get props => [
        totalRecipients,
        sent,
        delivered,
        opened,
        clicked,
        bounced,
        unsubscribed,
        complained,
        openRate,
        clickRate,
        bounceRate,
      ];
}
