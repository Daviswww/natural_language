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
  late String dominant;
  late Map<String, double> langResult;

  @override
  void initState() {
    langResult = {};
    super.initState();
    dominant = "";
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: controller,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      final result = await viewModel.getLanguageHypotheses(
                        controller.text,
                        99,
                      );
                      setState(() {
                        langResult = result;
                      });
                    },
                    child: const Text("Run"),
                  ),
                  TextButton(
                    onPressed: () async {
                      final result = await viewModel.getDominantLanguage(
                        controller.text,
                      );
                      setState(() {
                        dominant = result;
                      });
                    },
                    child: const Text("Dominant"),
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
              Text("Dominant: $dominant"),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    ...langResult.entries.map(
                      (e) => Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: Text(
                              "${e.key}:",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            "${e.value}",
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
