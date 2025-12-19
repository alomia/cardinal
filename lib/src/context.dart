import 'package:args/args.dart';

import 'argument.dart';

abstract class CardinalContext {
  Object? get logger;
  bool flag(String name);
  T? option<T>(String name);
  T? argument<T>(String name);
  List<String> get arguments;
}

class ArgsCardinalContext implements CardinalContext {
  final ArgResults results;
  final ArgResults globals;
  final List<CardinalArgument> definitions;
  final Object? _logger;

  ArgsCardinalContext({
    required this.results,
    required this.globals,
    required this.definitions,
    Object? logger,
  }) : _logger = logger;

  @override
  bool flag(String name) {
    if (results.options.contains(name)) {
      return results.flag(name);
    }

    if (globals.options.contains(name)) {
      return globals.flag(name);
    }

    return false;
  }

  @override
  T? option<T>(String name) {
    Object? value;

    if (results.options.contains(name)) {
      value = results[name];
    } else if (globals.options.contains(name)) {
      value = globals[name];
    }

    if (value == null) return null;
    if (value is T) return value as T;
    if (value is String) return _convert<T>(value);

    return null;
  }

  @override
  T? argument<T>(String name) {
    final index = definitions.indexWhere((a) => a.name == name);
    if (index == -1) return null;

    final raw = index < results.rest.length ? results.rest[index] : null;
    final arg = definitions[index] as CardinalArgument<T>;

    return arg.parse(raw);
  }

  @override
  List<String> get arguments => List.unmodifiable(results.rest);


  

  T? _convert<T>(String value) {
    return switch (T) {
      const (String) => value as T,
      const (int) => int.tryParse(value) as T?,
      const (double) => double.tryParse(value) as T?,
      const (bool) => (value.toLowerCase() == 'true' || value == '1') as T?,
      _ => null,
    };
  }
  
  @override
  Object? get logger => _logger;
}
