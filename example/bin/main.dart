import 'package:cardinal/cardinal.dart';

import '../lib/commands/hello_command.dart';

void main(List<String> args) {
  final app = CardinalApp(
    name: 'mycli',
    description: 'A sample CLI using Cardinal.',
    commands: [HelloCommand()],
  );
  
  app.run(args);
}
