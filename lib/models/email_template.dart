import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_template.g.dart';

@JsonSerializable()
class EmailTemplate extends Equatable {
  final String id;
  final String name;
  final String description;
  final String htmlContent;
  final String? textContent;
  final String? thumbnailUrl;
  final TemplateCategory category;
  final List<String> tags;
  final bool isCustom;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> variables;

  const EmailTemplate({
    required this.id,
    required this.name,
    this.description = '',
    required this.htmlContent,
    this.textContent,
    this.thumbnailUrl,
    this.category = TemplateCategory.custom,
    this.tags = const [],
    this.isCustom = true,
    required this.createdAt,
    required this.updatedAt,
    this.variables = const {},
  });

  factory EmailTemplate.fromJson(Map<String, dynamic> json) => _$EmailTemplateFromJson(json);
  Map<String, dynamic> toJson() => _$EmailTemplateToJson(this);

  EmailTemplate copyWith({
    String? id,
    String? name,
    String? description,
    String? htmlContent,
    String? textContent,
    String? thumbnailUrl,
    TemplateCategory? category,
    List<String>? tags,
    bool? isCustom,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? variables,
  }) {
    return EmailTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      htmlContent: htmlContent ?? this.htmlContent,
      textContent: textContent ?? this.textContent,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      isCustom: isCustom ?? this.isCustom,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      variables: variables ?? this.variables,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        htmlContent,
        textContent,
        thumbnailUrl,
        category,
        tags,
        isCustom,
        createdAt,
        updatedAt,
        variables,
      ];
}

enum TemplateCategory {
  custom,
  welcome,
  newsletter,
  promotional,
  transactional,
  announcement,
  event,
}
