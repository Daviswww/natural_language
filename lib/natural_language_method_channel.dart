import 'dart:convert';
import 'dart:ffi';

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
  Future<Map<String, double>> getLanguageHypotheses(String text, int withMaximum) async {
    final result = await methodChannel.invokeMethod<String>('getLanguageHypotheses', {
          "text": text,
          "withMaximum": withMaximum,
        }) ??
        "";
    final decode = json.decode(result) as Map<String, dynamic>;
    final map = Map<String, double>.from(decode);
    return map;
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
