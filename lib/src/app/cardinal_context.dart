import 'package:args/args.dart';

class CardinalContext {
  final ArgResults _argResults;
  final Map<String, int> _argIndexMap;

  CardinalContext(this._argResults, this._argIndexMap);

  T? option<T>(String name) {
    final value = _argResults[name];

    if (value is T) return value;

    return null;
  }

  String? argument(String name) {
    final index = _argIndexMap[name];
    if (index == null) return null;

    final rest = _argResults.rest;
    if (index >= rest.length) return null;

    return rest[index];
  }
}
