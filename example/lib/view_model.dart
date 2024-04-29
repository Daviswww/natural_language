import 'package:natural_language/natural_language.dart';
import 'package:natural_language_example/map_extension.dart';

class ViewModel {
  final NaturalLanguage _naturalLanguage;

  ViewModel({required NaturalLanguage naturalLanguage})
      : _naturalLanguage = naturalLanguage,
        super();

  Future<String> getDominantLanguage(String text) async {
    final result = await _naturalLanguage.getDominantLanguage(text) ?? "NULL";
    return result;
  }

  Future<Map<String, double>> getLanguageHypotheses(
      String text, int withMaximum) async {
    final result =
        await _naturalLanguage.getLanguageHypotheses(text, withMaximum);

    final sort = result.orderByValues(compareTo: (a, b) => b.compareTo(a));
    return sort;
  }

  Future<bool> isEnglish(String text, double threshold) async {
    final result = await _naturalLanguage.isEnglish(text, threshold) ?? false;
    return result;
  }
}
