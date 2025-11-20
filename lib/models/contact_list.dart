import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_list.g.dart';

@JsonSerializable()
class ContactList extends Equatable {
  final String id;
  final String name;
  final String description;
  final int contactCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final Map<String, dynamic> filters;

  const ContactList({
    required this.id,
    required this.name,
    this.description = '',
    this.contactCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.tags = const [],
    this.filters = const {},
  });

  factory ContactList.fromJson(Map<String, dynamic> json) => _$ContactListFromJson(json);
  Map<String, dynamic> toJson() => _$ContactListToJson(this);

  ContactList copyWith({
    String? id,
    String? name,
    String? description,
    int? contactCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    Map<String, dynamic>? filters,
  }) {
    return ContactList(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      contactCount: contactCount ?? this.contactCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      filters: filters ?? this.filters,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        contactCount,
        createdAt,
        updatedAt,
        tags,
        filters,
      ];
}
