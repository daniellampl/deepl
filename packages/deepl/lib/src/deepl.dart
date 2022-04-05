import 'package:deepl/deepl.dart';

/// {@template deepl}
///
/// {@endtemplate}
class Deepl {
  /// {@macro deepl}
  Deepl._();

  static Deepl? _instance;

  /// {@template deepl.instance}
  ///
  /// {@endtemplate}
  static Deepl get instance {
    return _instance ??= Deepl._();
  }

  DeeplApiClient? _apiClient;

  /// {@template deepl.setup}
  ///
  /// {@endtemplate}
  void configure({
    required DeeplConfig config,
  }) {
    _apiClient = DeeplApiClient(
      config: config,
    );
  }

  /// {@macro deepl.translate}
  Future<DeeplTranslation> translate({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
    DeeplConfig? config,
  }) async {
    if (_apiClient == null) {
      throw Exception('Deepl is not setup');
    }

    return _apiClient!.translate(
      config: config,
      text: text,
      targetLanguage: targetLanguage,
      sourceLanguage: sourceLanguage,
    );
  }

  /// {@macro deepl.translate_multiple}
  Future<List<DeeplTranslation>> translateMutliple({
    required List<String> texts,
    required String targetLanguage,
    String? sourceLanguage,
    DeeplConfig? config,
  }) async {
    if (_apiClient == null) {
      throw Exception('Deepl is not setup');
    }

    return _apiClient!.translateMultiple(
      config: config,
      texts: texts,
      targetLanguage: targetLanguage,
      sourceLanguage: sourceLanguage,
    );
  }

  /// {@macro deepl_client.getAvailableLanguages}
  Future<List<DeeplLanguage>> getSupportedLanguages({
    required DeeplLanguageType type,
    DeeplConfig? config,
  }) async {
    if (_apiClient == null) {
      throw Exception('Deepl is not setup');
    }

    return _apiClient!.getSupportedLanguages(
      type: type,
      config: config,
    );
  }

  /// {@macro deepl_client.getUsage}
  Future<DeeplUsage> getUsage({
    DeeplConfig? config,
  }) async {
    if (_apiClient == null) {
      throw Exception('Deepl is not setup');
    }

    return _apiClient!.getUsage(config: config);
  }
}
