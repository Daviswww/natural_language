// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://docs.flutter.dev/cookbook/testing/integration/introduction

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:natural_language/natural_language.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('isEnglish test', (WidgetTester tester) async {
    final NaturalLanguage naturalLanguage = NaturalLanguage();
    expect(await naturalLanguage.isEnglish("A Flutter plugin of Analyze natural language text and deduce its language-specific metadata.", 0.6), true);
  });
}
