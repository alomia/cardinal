abstract class CardinalArgument<T> {
  final String name;
  final String help;
  final bool required;
  final T? defaultValue;

  const CardinalArgument({
    required this.name,
    required this.help,
    this.required = false,
    this.defaultValue,
  });

  T? parse(String? value);

  String? validate(String? raw) {
    if (required && (raw == null || raw.isEmpty)) {
      return 'Missing required argument <$name>';
    }

    if (raw != null && parse(raw) == null) {
      return 'Invalid value for <$name>: "$raw"';
    }

    return null;
  }
}

class _StringArgument extends CardinalArgument<String> {
  const _StringArgument({
    required super.name,
    required super.help,
    super.required,
    super.defaultValue,
  });

  @override
  String? parse(String? value) => value ?? defaultValue;
}

class _IntArgument extends CardinalArgument<int> {
  const _IntArgument({
    required super.name,
    required super.help,
    super.required,
    super.defaultValue,
  });

  @override
  int? parse(String? value) {
    if (value == null) return defaultValue;
    return int.tryParse(value);
  }
}

class _DoubleArgument extends CardinalArgument<double> {
  const _DoubleArgument({
    required super.name,
    required super.help,
    super.required,
    super.defaultValue,
  });

  @override
  double? parse(String? value) {
    if (value == null) return defaultValue;
    return double.tryParse(value);
  }
}

CardinalArgument<String> stringArgument({
  required String name,
  required String help,
  bool required = false,
  String? defaultValue,
}) {
  return _StringArgument(
    name: name,
    help: help,
    required: required,
    defaultValue: defaultValue,
  );
}

CardinalArgument<int> intArgument({
  required String name,
  required String help,
  bool required = false,
  int? defaultValue,
}) {
  return _IntArgument(
    name: name,
    help: help,
    required: required,
    defaultValue: defaultValue,
  );
}

CardinalArgument<double> doubleArgument({
  required String name,
  required String help,
  bool required = false,
  double? defaultValue,
}) {
  return _DoubleArgument(
    name: name,
    help: help,
    required: required,
    defaultValue: defaultValue,
  );
}
