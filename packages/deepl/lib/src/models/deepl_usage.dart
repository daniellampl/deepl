import 'package:json_annotation/json_annotation.dart';

part 'deepl_usage.g.dart';

/// {@template deepl_usage}
/// The usage information of a specific Deepl user.
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class DeeplUsage {
  /// {@macro deepl_usage}
  const DeeplUsage({
    required this.characterCount,
    required this.characterLimit,
  });

  /// {@macro deepl_usage}
  factory DeeplUsage.fromJson(Map<String, dynamic> json) =>
      _$DeeplUsageFromJson(json);

  /// The amount of characters that have been translated in the currentp billing
  /// period.
  @JsonKey(name: 'character_count')
  final int characterCount;

  /// The amount characters the user is allowed to translation during the
  /// current billing period.
  @JsonKey(name: 'character_limit')
  final int characterLimit;
}
