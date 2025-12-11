class ArgumentDefinition {
  final String help;
  final bool isRequired;

  const ArgumentDefinition({
    required this.help,
    this.isRequired = true,
  });
}

ArgumentDefinition stringArgument({
  required String help,
  bool isRequired = true,
}) {
  return ArgumentDefinition(
    help: help,
    isRequired: isRequired,
  );
}
