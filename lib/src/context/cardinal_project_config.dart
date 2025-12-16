class CardinalProjectConfig {
  final String commandsDir;
  final String fileSuffix;
  final String classSuffix;

  const CardinalProjectConfig({
    required this.commandsDir,
    required this.fileSuffix,
    required this.classSuffix,
  });

  factory CardinalProjectConfig.defaults() {
    return const CardinalProjectConfig(
      commandsDir: 'lib/commands',
      fileSuffix: '_command.dart',
      classSuffix: 'Command',
    );
  }
}
