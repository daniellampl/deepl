import 'package:deepl/src/enums/deepl_subscription_type.dart';

/// {@template deepl_config}
/// Represents all necessary configuration information for interacting with the
/// Deepl API.
/// {@endtemplate}
class DeeplConfig {
  /// {@macro deepl_config}
  const DeeplConfig({
    required this.authKey,
    required this.subscription,
  });

  /// The Deepl API key.
  ///
  /// This key is only valid in combination with the [subscription] type the 
  /// user behind this key is subscribed to.
  final String authKey;

  /// {@macro deepl_subscription_type}
  final DeeplSubscriptionType subscription;
}
