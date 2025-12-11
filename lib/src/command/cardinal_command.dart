import 'package:args/command_runner.dart';
import 'package:cardinal/src/app/cardinal_context.dart';
import 'package:cardinal/src/definitions/argument_definition.dart';
import 'package:cardinal/src/definitions/option_definition.dart';

class CardinalCommand extends Command<void> {
  @override
  final String name;

  @override
  final String description;

  final Map<String, OptionDefinition> options;
  final List<CardinalCommand> subCommands;
  final Map<String, ArgumentDefinition> arguments;

  late final Map<String, int> _argIndexMap;

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

  Future<void> execute(CardinalContext context) async {}

  @override
  Future<void> run() async {
    final context = CardinalContext(argResults!, _argIndexMap);
    await execute(context);
  }
}
