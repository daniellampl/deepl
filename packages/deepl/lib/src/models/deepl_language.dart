import 'package:json_annotation/json_annotation.dart';

part 'deepl_language.g.dart';

/// {@template deepl_language}
///
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class DeeplLanguage {
  /// {@macro deepl_language}
  const DeeplLanguage({
    required this.language,
    required this.name,
    required this.supportsFormality,
  });

  /// {@template deepl_translation.fromJson}
  ///
  /// {@endTemplate}
  factory DeeplLanguage.fromJson(Map<String, dynamic> json) =>
      _$DeeplLanguageFromJson(json);

  /// The language code.
  final String language;

  /// The name of the langauge in english.
  final String name;

  /// Whether the target language supports formalities or not. This is online
  /// included for target languages.
  ///
  /// Returns `true`, if the target language supports formalities, otherwise
  /// `false`.
  ///
  /// Returns `null` if the language is a source language.
  @JsonKey(name: 'supports_formality')
  final bool? supportsFormality;
}
