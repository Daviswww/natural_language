import 'package:flutter_test/flutter_test.dart';
import 'package:natural_language/natural_language.dart';
import 'package:natural_language/natural_language_platform_interface.dart';
import 'package:natural_language/natural_language_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNaturalLanguagePlatform with MockPlatformInterfaceMixin implements NaturalLanguagePlatform {
  @override
  Future<String> getDominantLanguage(String text) => Future.value('en');

  @override
  Future<Map<String, double>> getLanguageHypotheses(String text, int withMaximum) => Future.value({"en": 0.6});

  @override
  Future<bool> isEnglish(String text, double threshold) => Future.value(false);
}

void main() {
  final NaturalLanguagePlatform initialPlatform = NaturalLanguagePlatform.instance;

  test('$MethodChannelNaturalLanguage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNaturalLanguage>());
  });

  test('getDominantLanguage', () async {
    NaturalLanguage naturalLanguagePlugin = NaturalLanguage();
    MockNaturalLanguagePlatform fakePlatform = MockNaturalLanguagePlatform();
    NaturalLanguagePlatform.instance = fakePlatform;

    expect(await naturalLanguagePlugin.getDominantLanguage("test"), 'en');
  });

  test('getLanguageHypotheses', () async {
    NaturalLanguage naturalLanguagePlugin = NaturalLanguage();
    MockNaturalLanguagePlatform fakePlatform = MockNaturalLanguagePlatform();
    NaturalLanguagePlatform.instance = fakePlatform;

    expect(await naturalLanguagePlugin.getLanguageHypotheses("test", 3), {"en": 0.6});
  });

  test('isEnglish', () async {
    NaturalLanguage naturalLanguagePlugin = NaturalLanguage();
    MockNaturalLanguagePlatform fakePlatform = MockNaturalLanguagePlatform();
    NaturalLanguagePlatform.instance = fakePlatform;

    expect(await naturalLanguagePlugin.isEnglish("text", 0.9), false);
  });
}
