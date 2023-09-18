import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'natural_language_method_channel.dart';

abstract class NaturalLanguagePlatform extends PlatformInterface {
  /// Constructs a NaturalLanguagePlatform.
  NaturalLanguagePlatform() : super(token: _token);

  static final Object _token = Object();

  static NaturalLanguagePlatform _instance = MethodChannelNaturalLanguage();

  /// The default instance of [NaturalLanguagePlatform] to use.
  ///
  /// Defaults to [MethodChannelNaturalLanguage].
  static NaturalLanguagePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NaturalLanguagePlatform] when
  /// they register themselves.
  static set instance(NaturalLanguagePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> getDominantLanguage(String text) {
    throw UnimplementedError('dominantLanguage() has not been implemented.');
  }

  Future<String> getLanguageHypotheses(String text, int withMaximum) {
    throw UnimplementedError('languageHypotheses() has not been implemented.');
  }

  Future<bool> isEnglish(String text, double threshold) {
    throw UnimplementedError('isEnglish() has not been implemented.');
  }
}
