import 'dart:io';

import 'package:yaml/yaml.dart';

import '../context/cardinal_project_config.dart';

CardinalProjectConfig loadProjectConfig() {
  final file = File('cardinal.yaml');

  if (!file.existsSync()) {
    return CardinalProjectConfig.defaults();
  }

  final yaml = loadYaml(file.readAsStringSync());

  return CardinalProjectConfig(
    commandsDir: yaml['structure']?['commands_directory'],
    fileSuffix: yaml['generation']?['file_suffix'],
    classSuffix: yaml['generation']?['class_suffix'],
  );
}
