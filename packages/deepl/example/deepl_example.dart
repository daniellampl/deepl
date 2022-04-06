// ignore_for_file: unused_local_variable

import 'package:deepl/deepl.dart';

Future<void> main() async {
  final deeplClient = DeeplApiClient(
    config: const DeeplConfig(
      authKey: 'YOUR_AUTH_KEY',
      subscription: DeeplSubscriptionType.free,
    ),
  );

  final sourceLanguages = await deeplClient.getSupportedLanguages(
    type: DeeplLanguageType.source,
  );

  final targetLanguages = await deeplClient.getSupportedLanguages(
    type: DeeplLanguageType.source,
  );

  final translation = await deeplClient.translate(
    text: 'Hello world!',
    targetLanguage: 'it',
  );

  final usage = await deeplClient.getUsage();
}
