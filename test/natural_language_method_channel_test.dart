import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:natural_language/natural_language_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelNaturalLanguage platform = MethodChannelNaturalLanguage();
  const MethodChannel channel = MethodChannel('natural_language');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case "getLanguageHypotheses":
            return '{"en": 0.9}';
          case "getDominantLanguage":
            return "en";
          case "isEnglish":
            return false;
          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getDominantLanguage', () async {
    expect(await platform.getDominantLanguage("test"), 'en');
  });

  test('getLanguageHypotheses', () async {
    expect(await platform.getLanguageHypotheses("test", 3), {"en": 0.9});
  });

  test('isEnglish', () async {
    expect(await platform.isEnglish("test", 0.5), false);
  });
}
