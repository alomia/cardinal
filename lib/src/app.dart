import 'dart:io';

import 'package:args/command_runner.dart';

import 'adapter_args.dart';
import 'command.dart';
import 'option.dart';

class CardinalApp {
  final String name;
  final String description;
  final List<CardinalOption> globalOptions;
  final List<CardinalCommand> commands;

  CardinalApp({
    required this.name,
    required this.description,
    this.globalOptions = const [],
    this.commands = const [],
  });

  Future<void> run(List<String> args) async {
    final runner = CommandRunner(name, description);

    for (final opt in globalOptions) {
      opt.register(runner.argParser);
    }

    for (final cmd in commands) {
      runner.addCommand(ArgsCommandAdapter(cmd));
    }

    try {
      await runner.run(args);
    } on UsageException catch (e) {
      stderr.writeln(e.message);
      stderr.writeln('');
      stderr.writeln(e.usage);
      exitCode = 64;
    } catch (e) {
      print(e);
    }
  }
}
