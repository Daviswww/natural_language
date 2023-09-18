import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'natural_language_platform_interface.dart';

/// An implementation of [NaturalLanguagePlatform] that uses method channels.
class MethodChannelNaturalLanguage extends NaturalLanguagePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('natural_language');

  @override
  Future<String> getDominantLanguage(String text) async {
    final result = await methodChannel.invokeMethod<String>('getDominantLanguage', {'text': text}) ?? "";
    return result;
  }

  @override
  Future<String> getLanguageHypotheses(String text, int withMaximum) async {
    final result = await methodChannel.invokeMethod<String>('getLanguageHypotheses', {
          "text": text,
          "withMaximum": withMaximum,
        }) ??
        "";
    return result;
  }

  @override
  Future<bool> isEnglish(String text, double threshold) async {
    final result = await methodChannel.invokeMethod<bool>('isEnglish', {
          "text": text,
          "threshold": threshold,
        }) ??
        false;
    return result;
  }
}
