import 'package:cardinal/cardinal.dart';

class HelloCommand extends CardinalCommand {
  HelloCommand()
    : super(
        name: 'hello',
        description: 'Greets a user.',
        arguments: {
          'name': stringArgument(help: 'The person to greet.')
        },
        options: {
          'shout': flagOption(
            help: 'Use uppercase output.',
            abbr: 's'
          ),
        },
      );

  @override
  Future<void> execute(CardinalContext context) async {
    var name = context.argument('name');
    var shout = context.option<bool>('shout') ?? false;

    var message = "Hello, $name!";
    if (shout) message = message.toUpperCase();

    print(message);
  }
}
