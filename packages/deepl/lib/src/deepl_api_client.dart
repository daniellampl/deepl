import 'dart:convert';
import 'dart:io';

import 'package:deepl/src/enums/enums.dart';
import 'package:deepl/src/models/models.dart';
import 'package:http/http.dart' as http;

/// {@template deepl_client}
/// A client for interacting with the Deepl API.
/// {@endtemplate}
class DeeplApiClient {
  /// {@macro deepl_client}
  DeeplApiClient({
    this.config,
    http.Client? httpClient,
  }) : httpClient = httpClient ?? http.Client();

  /// {@macro deepl_config}
  final DeeplConfig? config;

  /// {@template deepl_client.http_client}
  ///
  /// {@endtemplate}
  final http.Client httpClient;

  /// {@template deepl_client.translate}
  /// Translates the given [text] to the given [targetLanguage].
  ///
  /// Returns the translated text in the given [targetLanguage].
  ///
  /// See also:
  /// - [translateMultiple] for translating multiple texts at once.
  /// - [Documentation](https://www.deepl.com/de/docs-api/translating-text/)
  /// {@endtemplate}
  Future<DeeplTranslation> translate({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
    DeeplConfig? config,
  }) async {
    final translations = await translateMultiple(
      texts: [text],
      targetLanguage: targetLanguage,
      sourceLanguage: sourceLanguage,
      config: config,
    );
    return translations.first;
  }

  /// {@template deepl_client.translate_multiple}
  /// Translates a list of [texts] to the given [targetLanguage].
  ///
  /// Returns a list of translation the given [texts] got translated into.
  ///
  /// See also:
  /// - [Documentation](https://www.deepl.com/de/docs-api/translating-text/)
  /// {@endtemplate}
  Future<List<DeeplTranslation>> translateMultiple({
    required List<String> texts,
    required String targetLanguage,
    String? sourceLanguage,
    DeeplConfig? config,
  }) async {
    final queryParameters = <String, String>{
      'text': jsonEncode(texts),
      'target_lang': targetLanguage,
    };

    if (sourceLanguage != null) {
      queryParameters['source_lang'] = sourceLanguage;
    }

    final response = await _makeRequest(
      path: '/v2/translate',
      queryParameters: queryParameters,
      config: config,
    );

    final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return (decodedResponse['translations'] as List<dynamic>)
        .map(
          (dynamic e) => DeeplTranslation.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  /// {@template deepl_client.getAvailableLanguages}
  /// Gets all supported languages for the given language [type].
  ///
  /// If the [type] is [DeeplLanguageType.source], all supported source
  /// languages get returned.
  ///
  /// If the [type] is [DeeplLanguageType.target], all supported target
  /// lanaguges get returned.
  ///
  /// See also:
  /// - [Documentation](https://www.deepl.com/de/docs-api/other-functions/listing-supported-languages/)
  /// {@endtemplate}
  Future<List<DeeplLanguage>> getSupportedLanguages({
    required DeeplLanguageType type,
    DeeplConfig? config,
  }) async {
    final response = await _makeRequest(
      path: '/v2/languages',
      queryParameters: <String, String>{
        'type': type == DeeplLanguageType.source ? 'source' : 'target',
      },
      config: config,
    );

    final decodedResponse = jsonDecode(response.body) as List<dynamic>;
    return decodedResponse
        .map((dynamic e) => DeeplLanguage.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// {@template deepl_client.getUsage}
  /// Gets the subscription usage information for the given [DeeplConfig].
  ///
  /// See also:
  /// - [Documentation](https://www.deepl.com/de/docs-api/other-functions/monitoring-usage/)
  /// {@endtemplate}
  Future<DeeplUsage> getUsage({
    DeeplConfig? config,
  }) async {
    final response = await _makeRequest(
      path: '/v2/usage',
      config: config,
    );

    final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return DeeplUsage.fromJson(decodedResponse);
  }

  /// Excecutes the request against the Deepl endpoint with the given [path].
  ///
  /// The request gets either executed with the [DeeplApiClient]'s [config] (if
  /// available) or with the given request specific [config]. One of both must
  /// be given.
  Future<http.Response> _makeRequest({
    required String path,
    Map<String, String>? queryParameters,
    DeeplConfig? config,
  }) async {
    assert(
      this.config != null || config != null,
      'Either the config of the DeeplApiClient instance or the request '
      'specific config must not be null!',
    );

    final configToUse = config ?? this.config!;

    // all Deepl endpoints are available as get and post operation, post is the
    // recommended operation though.
    return httpClient.post(
      Uri.https(_getAutority(configToUse), path, queryParameters),
      headers: {
        HttpHeaders.authorizationHeader:
            'DeepL-Auth-Key ${configToUse.authKey}',
      },
    );
  }

  /// Returns the Deepl authority for the given [config].
  ///
  /// There is a different authority for each Deepl abo.
  String _getAutority(DeeplConfig config) {
    return config.subscription == DeeplSubscriptionType.free
        ? 'api-free.deepl.com'
        : 'api-pro.deepl.com';
  }
}
