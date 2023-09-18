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
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getDominantLanguage', () async {
    expect(await platform.getDominantLanguage("test"), '42');
  });

  test('getLanguageHypotheses', () async {
    expect(await platform.getLanguageHypotheses("test", 3), '42');
  });
}
