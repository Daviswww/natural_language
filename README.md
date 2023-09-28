[![release](https://github.com/Daviswww/natural_language/actions/workflows/action.yaml/badge.svg?branch=main)](https://github.com/Daviswww/natural_language/actions/workflows/action.yaml)
![Pub Version](https://img.shields.io/pub/v/natural_language)

# natural_language
A Flutter plugin of Analyze natural language text and deduce its language-specific metadata.

## Usage

### Get DominantLanguage
Finds the most likely language of a piece of text.

```
  Future<String> getDominantLanguage(String text) async {
    final result = await _naturalLanguage.getDominantLanguage(text) ?? "NULL";
    return result;
  }
```

### Get LanguageHypotheses
Generates the probabilities of possible languages for the processed text.

```
  Future<Map<String, double>> getLanguageHypotheses(String text, int withMaximum) async {
    final result = await _naturalLanguage.getLanguageHypotheses(text, withMaximum);
    return result;
  }
```


### isEnglish
Detects whether it is English.

```
  Future<bool> isEnglish(String text, double threshold) async {
    final result = await _naturalLanguage.isEnglish(text, threshold) ?? false;
    return result;
  }
```

--------------------------------------------------------------------------------

