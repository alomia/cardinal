import 'argument.dart';
import 'context.dart';
import 'option.dart';

abstract class CardinalCommand {
  final String name;
  final String description;

  final List<CardinalArgument> arguments;
  final List<CardinalOption> options;
  final List<CardinalCommand> subcommands;

  CardinalCommand({
    required this.name,
    required this.description,
    this.arguments = const [],
    this.options = const [],
    this.subcommands = const [],
  });

  Future<void> execute(CardinalContext context);
}
