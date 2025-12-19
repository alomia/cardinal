import 'package:cardinal/cardinal.dart';

class HelloCommand extends CardinalCommand {
  HelloCommand()
    : super(
        name: 'hello',
        description: 'Greets a user.',
        arguments: [
          stringArgument(
            name: 'name',
            help: 'Name of the user',
            required: true,
          ),
        ],
        options: [
          flagOption(
            name: 'upper',
            abbr: 'u',
            help: 'Print greeting in uppercase',
          ),
        ],
      );

  @override
  Future<void> execute(CardinalContext context) async {
    final name = context.argument<String>('name')!;
    final upper = context.flag('upper');

    final message = 'Hello, $name';
    print(upper ? message.toUpperCase() : message);
  }
}
