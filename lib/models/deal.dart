import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deal.g.dart';

@JsonSerializable()
class Deal extends Equatable {
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

  const Deal({
    required this.id,
    required this.title,
    this.description,
    required this.value,
    this.currency = 'USD',
    this.stage = DealStage.lead,
    this.priority = DealPriority.medium,
    this.contactId,
    this.assignedTo,
    required this.createdAt,
    required this.updatedAt,
    this.expectedCloseDate,
    this.closedAt,
    this.tags = const [],
    this.customFields = const {},
    this.activities = const [],
  });

  factory Deal.fromJson(Map<String, dynamic> json) => _$DealFromJson(json);
  Map<String, dynamic> toJson() => _$DealToJson(this);

  Deal copyWith({
    String? id,
    String? title,
    String? description,
    double? value,
    String? currency,
    DealStage? stage,
    DealPriority? priority,
    String? contactId,
    String? assignedTo,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? expectedCloseDate,
    DateTime? closedAt,
    List<String>? tags,
    Map<String, dynamic>? customFields,
    List<Activity>? activities,
  }) {
    return Deal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      value: value ?? this.value,
      currency: currency ?? this.currency,
      stage: stage ?? this.stage,
      priority: priority ?? this.priority,
      contactId: contactId ?? this.contactId,
      assignedTo: assignedTo ?? this.assignedTo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      expectedCloseDate: expectedCloseDate ?? this.expectedCloseDate,
      closedAt: closedAt ?? this.closedAt,
      tags: tags ?? this.tags,
      customFields: customFields ?? this.customFields,
      activities: activities ?? this.activities,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        value,
        currency,
        stage,
        priority,
        contactId,
        assignedTo,
        createdAt,
        updatedAt,
        expectedCloseDate,
        closedAt,
        tags,
        customFields,
        activities,
      ];
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

@JsonSerializable()
class Activity extends Equatable {
  final String id;
  final String dealId;
  final ActivityType type;
  final String title;
  final String? description;
  final DateTime createdAt;
  final String? createdBy;
  final DateTime? dueDate;
  final bool isCompleted;

  const Activity({
    required this.id,
    required this.dealId,
    required this.type,
    required this.title,
    this.description,
    required this.createdAt,
    this.createdBy,
    this.dueDate,
    this.isCompleted = false,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  Activity copyWith({
    String? id,
    String? dealId,
    ActivityType? type,
    String? title,
    String? description,
    DateTime? createdAt,
    String? createdBy,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return Activity(
      id: id ?? this.id,
      dealId: dealId ?? this.dealId,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        dealId,
        type,
        title,
        description,
        createdAt,
        createdBy,
        dueDate,
        isCompleted,
      ];
}

enum ActivityType {
  call,
  meeting,
  email,
  task,
  note,
}
