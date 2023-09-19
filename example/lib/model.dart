// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ListModel {
  final List<Model> list;
  ListModel({
    required this.list,
  });

  ListModel copyWith({
    List<Model>? list,
  }) {
    return ListModel(
      list: list ?? this.list,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'list': list.map((x) => x.toMap()).toList(),
    };
  }

  factory ListModel.fromMap(Map<String, dynamic> map) {
    return ListModel(
      list: List<Model>.from(
        (map['list'] as List<int>).map<Model>(
          (x) => Model.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListModel.fromJson(String source) => ListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ListModel(list: $list)';

  @override
  bool operator ==(covariant ListModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.list, list);
  }

  @override
  int get hashCode => list.hashCode;
}

class Model {
  final String lang;
  final double probability;
  Model({
    required this.lang,
    required this.probability,
  });

  Model copyWith({
    String? lang,
    double? probability,
  }) {
    return Model(
      lang: lang ?? this.lang,
      probability: probability ?? this.probability,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lang': lang,
      'probability': probability,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      lang: map['lang'] as String,
      probability: map['probability'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Model(lang: $lang, probability: $probability)';

  @override
  bool operator ==(covariant Model other) {
    if (identical(this, other)) return true;

    return other.lang == lang && other.probability == probability;
  }

  @override
  int get hashCode => lang.hashCode ^ probability.hashCode;
}
