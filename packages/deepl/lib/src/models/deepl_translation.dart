import 'package:json_annotation/json_annotation.dart';

part 'deepl_translation.g.dart';

/// {@template deepl_translation}
/// A translation result a specifc text got translated to by deepl.
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class DeeplTranslation {
  /// {@macro deepl_translation}
  const DeeplTranslation({
    required this.detectedSourceLanguage,
    required this.text,
  });

  /// {@macro deepl_translation}
  factory DeeplTranslation.fromJson(Map<String, dynamic> json) =>
      _$DeeplTranslationFromJson(json);

  /// The source language Deepl detected during the translation of a given text.
  @JsonKey(name: 'detected_source_language')
  final String detectedSourceLanguage;

  /// The translated text.
  @JsonKey(name: 'text')
  final String text;
}
