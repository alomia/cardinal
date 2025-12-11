<img src="https://raw.githubusercontent.com/alomia/cardinal/main/assets/github-header.png" alt="Cardinal header" />

# Cardinal

<p>
  <strong>A modern, declarative, zero-boilerplate CLI framework for Dart.</strong><br/>
  Clean API. Strong DX. Powerful command architecture.
</p>

---

## Overview

**Cardinal** is a modern and declarative framework for building Command Line Interfaces in Dart.  
Its focus is developer experience, clarity, and zero boilerplate.

Unlike traditional argument parsers, Cardinal lets you define:

- **Commands**  
- **Subcommands**
- **Options** (typed, flags or value-based)
- **Positional arguments** (named declaratively)
- **Context-driven execution**

All with a clean, expressive, and minimal API.

---

## Features

- Declarative command definitions  
- Typed options: `string`, `int`, `bool` (flags)  
- Named positional arguments  
- Powerful execution context  
- Zero-boilerplate command registration  
- Clean folder structure for large CLIs  
- Designed for extensibility (completions, validators, dynamic types)

---

## Installing

Add to your `pubspec.yaml`:

```yaml
dependencies:
  cardinal: ^0.1.0

```
---

## Quick Start
### 1. Create your command
``` dart
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
```

### 2. Create your CLI entrypoint

``` dart
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
```

## Example Usage

``` sh
dart run main.dart hello Cardinal
Hello, Cardinal!

```

### With flags:

``` sh
dart run main.dart hello Cardinal -s
HELLO, CARDINAL!

```
---

## Philosophy

Cardinal is built upon four principles:

**1. Clarity first**

Commands should look like definitions, not plumbing.

**2. Declarative API**

The CLI structure must be readable at a glance.

**3. Zero boilerplate**

You write commands, not parser code.

**4. Strong DX**

Consistency, predictability, and meaningful error messages.

---