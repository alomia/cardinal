import 'dart:io';

import 'package:args/command_runner.dart';

import '../command/cardinal_command.dart';
import '../utils/load_project_config.dart';



class CardinalApp {
  final String name;
  final String description;
  final String version;
  final String? configPath;
  final List<CardinalCommand> commands;

  CardinalApp({
    required this.name,
    required this.description,
    required this.version,
    required this.commands,
    this.configPath,
  });

  Future<void> run(List<String> args) async {
    final runner = CommandRunner<void>(name, description);

    final projectConfig = loadProjectConfig();

    for (var command in commands) {
      command.attachProjectConfig(projectConfig);
      runner.addCommand(command);
    }

    try {
      await runner.run(args);
    } on UsageException catch (e) {
      print(e.message);
      print('\n${e.usage}');
    } catch (e) {
      stderr.writeln(e);
    }
  }
}
