import 'package:args/args.dart';

abstract class CardinalOption {
  final String name;
  final String help;
  final String? abbr;

  CardinalOption({required this.name, required this.help, this.abbr});

  void register(ArgParser parser);
}

class _FlagOption extends CardinalOption {
  final bool defaultValue;
  final bool hidden;
  final List<String> aliases;

  _FlagOption({
    required super.name,
    required super.help,
    super.abbr,
    this.defaultValue = false,
    this.hidden = false,
    this.aliases = const [],
  });

  @override
  void register(ArgParser parser) {
    parser.addFlag(
      name,
      abbr: abbr,
      help: help,
      defaultsTo: defaultValue,
      hide: hidden,
      aliases: aliases,
    );
  }
}

class _ValueOption<T> extends CardinalOption {
  final T? defaultValue;
  final String? valueHelp;
  final Iterable<String>? allowed;
  final bool hidden;
  final List<String> aliases;

  _ValueOption({
    required super.name,
    required super.help,
    super.abbr,
    this.defaultValue,
    this.valueHelp,
    this.allowed,
    this.hidden = false,
    this.aliases = const [],
  });

  @override
  void register(ArgParser parser) {
    parser.addOption(
      name,
      abbr: abbr,
      help: help,
      valueHelp: valueHelp,
      allowed: allowed,
      defaultsTo: defaultValue?.toString(),
      hide: hidden,
      aliases: aliases,
    );
  }
}

CardinalOption flagOption({
  required String name,
  required String help,
  String? abbr,
  bool defaultValue = false,
  bool hidden = false,
  List<String> aliases = const [],
}) {
  return _FlagOption(
    name: name,
    help: help,
    abbr: abbr,
    defaultValue: defaultValue,
    hidden: hidden,
    aliases: aliases,
  );
}

CardinalOption stringOption({
  required String name,
  required String help,
  String? abbr,
  String? defaultValue,
  String? valueHelp,
  Iterable<String>? allowed,
  bool hidden = false,
  List<String> aliases = const [],
}) {
  return _ValueOption<String>(
    name: name,
    help: help,
    abbr: abbr,
    defaultValue: defaultValue,
    valueHelp: valueHelp,
    allowed: allowed,
    hidden: hidden,
    aliases: aliases,
  );
}

CardinalOption intOption({
  required String name,
  required String help,
  String? abbr,
  int? defaultValue,
  String? valueHelp,
  Iterable<int>? allowed,
  bool hidden = false,
  List<String> aliases = const [],
}) {
  return _ValueOption<int>(
    name: name,
    help: help,
    abbr: abbr,
    defaultValue: defaultValue,
    valueHelp: valueHelp,
    allowed: allowed?.map((e) => e.toString()),
    hidden: hidden,
    aliases: aliases,
  );
}

CardinalOption doubleOption({
  required String name,
  required String help,
  String? abbr,
  double? defaultValue,
  String? valueHelp,
  Iterable<double>? allowed,
  bool hidden = false,
  List<String> aliases = const [],
}) {
  return _ValueOption<double>(
    name: name,
    help: help,
    abbr: abbr,
    defaultValue: defaultValue,
    valueHelp: valueHelp,
    allowed: allowed?.map((e) => e.toString()),
    hidden: hidden,
    aliases: aliases,
  );
}
