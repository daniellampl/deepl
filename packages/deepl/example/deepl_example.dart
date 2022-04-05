import 'package:deepl/deepl.dart';

Future<void> main() async {
  Deepl.instance.configure(
    config: const DeeplConfig(
      authKey: 'YOUR_AUTH_KEY',
      subscription: DeeplSubscriptionType.free,
    ),
  );

  // final languages = await Deepl.instance
  //     .getSupportedLanguages(type: DeeplLanguageType.source);
}
