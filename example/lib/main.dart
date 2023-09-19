import 'package:flutter/material.dart';
import 'package:natural_language/natural_language.dart';
import 'package:natural_language_example/view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late NaturalLanguage naturalLanguage;
  late ViewModel viewModel;
  late TextEditingController controller;
  late String text;

  @override
  void initState() {
    super.initState();
    text = "";
    controller = TextEditingController();
    controller.text = "Hello World";
    naturalLanguage = NaturalLanguage();
    viewModel = ViewModel(naturalLanguage: naturalLanguage);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text("Langs: $text"),
            TextField(
              controller: controller,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    final result = await viewModel.getDominantLanguage(
                      controller.text,
                    );
                    setState(() {
                      text = result;
                    });
                  },
                  child: const Text("Domain"),
                ),
                TextButton(
                  onPressed: () async {
                    final result = await viewModel.getLanguageHypotheses(
                      controller.text,
                      3,
                    );
                    setState(() {
                      text = result.toString();
                    });
                  },
                  child: const Text("Mult"),
                ),
                TextButton(
                  onPressed: () async {
                    final result = await viewModel.isEnglish(
                      controller.text,
                      0.9,
                    );
                    debugPrint("$result");
                  },
                  child: const Text("isEnglish"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
