import 'package:cardinal/cardinal.dart';
import 'package:test/test.dart';

void main() {
  group('Cardinal basic command execution', () {
    test('executes command with required argument', () async {
      String? receivedName;

      final app = CardinalApp(
        name: 'testcli',
        description: 'Test CLI',
        commands: [
          _TestCommand(
            onExecute: (context) {
              receivedName = context.argument<String>('name');
            },
          ),
        ],
      );

      await app.run(['test', 'Alejandro']);

      expect(receivedName, equals('Alejandro'));
    });

    test('reads flag option correctly', () async {
      bool? upper;

      final app = CardinalApp(
        name: 'testcli',
        description: 'Test CLI',
        commands: [
          _FlagCommand(
            onExecute: (context) {
              upper = context.flag('upper');
            },
          ),
        ],
      );

      await app.run(['flag', '--upper']);

      expect(upper, isTrue);
    });
  });
}

class _TestCommand extends CardinalCommand {
  final void Function(CardinalContext) onExecute;

  _TestCommand({required this.onExecute})
    : super(
        name: 'test',
        description: 'Test command',
        arguments: [stringArgument(name: 'name', help: 'Name', required: true)],
      );

  @override
  Future<void> execute(CardinalContext context) async {
    onExecute(context);
  }
}

class _FlagCommand extends CardinalCommand {
  final void Function(CardinalContext) onExecute;

  _FlagCommand({required this.onExecute})
    : super(
        name: 'flag',
        description: 'Flag command',
        options: [flagOption(name: 'upper', help: 'Uppercase')],
      );

  @override
  Future<void> execute(CardinalContext context) async {
    onExecute(context);
  }
}
