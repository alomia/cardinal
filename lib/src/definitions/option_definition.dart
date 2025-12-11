class OptionDefinition {
  final String help;
  final String? abbr;
  final dynamic defaultValue;
  final List<String> allowed;
  final bool isFlag;
  final Type type;

  const OptionDefinition({
    required this.help,
    this.abbr,
    this.defaultValue,
    this.allowed = const [],
    this.isFlag = false,
    required this.type,
  });
}

OptionDefinition stringOption({
  required String help,
  String? abbr,
  String? defaultValue,
}) {
  return OptionDefinition(
    help: help,
    abbr: abbr,
    defaultValue: defaultValue,
    type: String,
  );
}

OptionDefinition intOption({
  required String help,
  String? abbr,
  int defaultValue = 0,
}) {
  return OptionDefinition(
    help: help,
    abbr: abbr,
    defaultValue: defaultValue,
    type: int,
  );
}

OptionDefinition flagOption({
  required String help,
  String? abbr,
  bool defaultValue = false,
}) {
  return OptionDefinition(
    help: help,
    abbr: abbr,
    defaultValue: defaultValue,
    isFlag: true,
    type: bool,
  );
}
