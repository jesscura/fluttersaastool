import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact extends Equatable {
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

  const Contact({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.company,
    this.phoneNumber,
    this.tags = const [],
    this.customFields = const {},
    this.status = ContactStatus.active,
    required this.createdAt,
    this.lastEmailedAt,
    this.emailsSent = 0,
    this.emailsOpened = 0,
    this.emailsClicked = 0,
    this.isVerified = false,
    this.verificationStatus,
  });

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return firstName ?? lastName ?? email;
  }

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);

  Contact copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? company,
    String? phoneNumber,
    List<String>? tags,
    Map<String, dynamic>? customFields,
    ContactStatus? status,
    DateTime? createdAt,
    DateTime? lastEmailedAt,
    int? emailsSent,
    int? emailsOpened,
    int? emailsClicked,
    bool? isVerified,
    String? verificationStatus,
  }) {
    return Contact(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      company: company ?? this.company,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      tags: tags ?? this.tags,
      customFields: customFields ?? this.customFields,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastEmailedAt: lastEmailedAt ?? this.lastEmailedAt,
      emailsSent: emailsSent ?? this.emailsSent,
      emailsOpened: emailsOpened ?? this.emailsOpened,
      emailsClicked: emailsClicked ?? this.emailsClicked,
      isVerified: isVerified ?? this.isVerified,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        company,
        phoneNumber,
        tags,
        customFields,
        status,
        createdAt,
        lastEmailedAt,
        emailsSent,
        emailsOpened,
        emailsClicked,
        isVerified,
        verificationStatus,
      ];
}

enum ContactStatus {
  active,
  unsubscribed,
  bounced,
  complained,
}
