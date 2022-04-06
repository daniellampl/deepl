import 'package:deepl/src/enums/deepl_subscription_type.dart';

/// {@template deepl_config}
/// The configuration information of a user's deepl subscription.
/// {@endtemplate}
class DeeplConfig {
  /// {@macro deepl_config}
  const DeeplConfig({
    required this.authKey,
    required this.subscription,
  });

  /// The Deepl API key.
  ///
  /// This key is only valid in combination with the corresponding 
  /// [subscription] type the user behind this key is subscribed to.
  final String authKey;

  /// {@macro deepl_subscription_type}
  final DeeplSubscriptionType subscription;
}
