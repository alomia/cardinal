import 'package:args/command_runner.dart';

import 'command.dart';
import 'context.dart';

class ArgsCommandAdapter extends Command {
  final CardinalCommand _source;
  final Object? logger;

  ArgsCommandAdapter(this._source, {this.logger}) {
    for (final opt in _source.options) {
      opt.register(argParser);
    }

    for (final sub in _source.subcommands) {
      addSubcommand(ArgsCommandAdapter(sub, logger: logger));
    }
  }

  @override
  String get invocation {
    final buffer = StringBuffer();
    buffer.write(_source.name);

    for (final argument in _source.arguments) {
      buffer.write(
        argument.required ? ' <${argument.name}>' : ' [${argument.name}]',
      );
    }

    return buffer.toString();
  }

  @override
  String get description => _source.description;

  @override
  String get name => _source.name;

  @override
  Future<void> run() async {
    final rawArgs = argResults!.rest;

    for (var i = 0; i < _source.arguments.length; i++) {
      final def = _source.arguments[i];
      final raw = i < rawArgs.length ? rawArgs[i] : null;

      final error = def.validate(raw);
      if (error != null) {
        throw UsageException(error, usage);
      }
    }

    final context = ArgsCardinalContext(
      results: argResults!,
      globals: globalResults!,
      definitions: _source.arguments,
      
    );
    await _source.execute(context);
  }
}
