import 'natural_language_platform_interface.dart';

class NaturalLanguage {
  Future<String?> getDominantLanguage(String text) {
    return NaturalLanguagePlatform.instance.getDominantLanguage(text);
  }

  Future<Map<String, double>> getLanguageHypotheses(
      String text, int withMaximum) {
    return NaturalLanguagePlatform.instance
        .getLanguageHypotheses(text, withMaximum);
  }

  Future<bool?> isEnglish(String text, double threshold) {
    return NaturalLanguagePlatform.instance.isEnglish(text, threshold);
  }
}
