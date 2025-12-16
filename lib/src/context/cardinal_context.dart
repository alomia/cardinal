import 'package:args/args.dart';

import 'cardinal_project_config.dart';

class CardinalContext {
  final ArgResults args;
  final Map<String, int> argIndexMap;
  final CardinalProjectConfig project;

  CardinalContext({
    required this.args,
    required this.argIndexMap,
    required this.project,
  });

  T? option<T>(String name) {
    final value = args[name];

    if (value is T) return value;

    return null;
  }

  String? argument(String name) {
    final index = argIndexMap[name];
    if (index == null) return null;

    final rest = args.rest;
    if (index >= rest.length) return null;

    return rest[index];
  }
}
