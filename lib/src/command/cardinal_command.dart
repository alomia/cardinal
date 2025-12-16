import 'package:args/command_runner.dart';

import '../context/cardinal_context.dart';
import '../context/cardinal_project_config.dart';
import '../definitions/argument_definition.dart';
import '../definitions/option_definition.dart';

class CardinalCommand extends Command<void> {
  @override
  final String name;

  @override
  final String description;

  final Map<String, OptionDefinition> options;
  final List<CardinalCommand> subCommands;
  final Map<String, ArgumentDefinition> arguments;

  late final Map<String, int> _argIndexMap;
  late CardinalProjectConfig _projectConfig;

  CardinalCommand({
    required this.name,
    required this.description,
    this.options = const {},
    this.subCommands = const [],
    this.arguments = const {},
  }) {
    // add flags or options
    options.forEach((name, opt) {
      if (opt.isFlag) {
        argParser.addFlag(
          name,
          abbr: opt.abbr,
          help: opt.help,
          defaultsTo: opt.defaultValue,
        );
      } else {
        argParser.addOption(
          name,
          abbr: opt.abbr,
          help: opt.help,
          defaultsTo: opt.defaultValue,
        );
      }
    });

    subCommands.forEach(addSubcommand);

    _argIndexMap = arguments.keys.toList().asMap().map(
      (index, name) => MapEntry(name, index),
    );
  }

  void attachProjectConfig(CardinalProjectConfig config) {
    _projectConfig = config;

    for (var subCommand in subCommands) {
      subCommand.attachProjectConfig(config);
    }
  }

  void _validateRequiredArguments(List<String> positionalArgs) {
    final requiredArguments = arguments.entries
        .where((e) => e.value.isRequired)
        .map((e) => e.key)
        .toList();

    if (positionalArgs.length < requiredArguments.length) {
      final missing = requiredArguments
          .sublist(positionalArgs.length)
          .join(', ');

      throw UsageException('Missing required arguments: $missing', usage);
    }
  }

  Future<void> execute(CardinalContext context) async {}

  @override
  String get invocation {
    final argsUsage = arguments.entries
        .map((e) {
          return e.value.isRequired ? '<${e.key}>' : '[${e.key}]';
        })
        .join(' ');

    return '${runner!.executableName} $name $argsUsage';
  }

  @override
  Future<void> run() async {
    _validateRequiredArguments(argResults!.rest);

    final context = CardinalContext(
      args: argResults!,
      argIndexMap: _argIndexMap,
      project: _projectConfig,
    );

    await execute(context);
  }
}
