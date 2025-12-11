import 'package:cardinal/cardinal.dart';

import '../lib/commands/hello_command.dart';


void main(List<String> args) {
  final app = CardinalApp(
    name: 'mycli',
    description: 'A sample CLI using Cardinal.',
    version: '0.1.0',
    commands: [HelloCommand()],
  );

  app.run(args);
}
