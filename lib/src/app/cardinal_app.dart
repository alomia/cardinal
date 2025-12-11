import 'package:args/command_runner.dart';
import 'package:cardinal/src/command/cardinal_command.dart';

class CardinalApp {
  final String name;
  final String description;
  final String version;
  final List<CardinalCommand> commands;

  CardinalApp({
    required this.name,
    required this.description,
    required this.version,
    required this.commands,
  });

  Future<void> run(List<String> args) async {
    final runner = CommandRunner<void>(name, description);

    for (var command in commands) {
      runner.addCommand(command);
    }

    try {
      await runner.run(args);
    } on UsageException catch (e) {
      print(e.message);
      // print(runner.usage);
    } catch (e) {
      print('Fatal error $e');
    }
  }
}
