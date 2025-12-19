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

Unlike traditional argument parsers that focus on flags and parsing,
Cardinal focuses on commands as first-class concepts.


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
- Designed for extensibility (validators, custom types, future completions)

---

## Installing

Add to your `pubspec.yaml`:

```yaml
dependencies:
  cardinal: ^0.3.0

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
```

### 2. Create your CLI entrypoint

``` dart
import 'package:cardinal/cardinal.dart';

import 'commands/hello_command.dart';

void main(List<String> args) {
  final app = CardinalApp(
    name: 'mycli',
    description: 'A sample CLI using Cardinal.',
    commands: [HelloCommand()],
  );
  
  app.run(args);
}
```

## Example Usage

``` sh
dart run main.dart hello Cardinal
Hello, Cardinal

```

### With flags:

``` sh
dart run main.dart hello Cardinal --upper
HELLO, CARDINAL

```

### Help output

``` sh
dart run main.dart hello -h

Greets a user.

Usage: hello <name>
-h, --help          Print this usage information.
-u, --[no-]upper    Print greeting in uppercase

Run "mycli help" to see global options.
```
---

## Why Cardinal?

Cardinal is not just an argument parser.

It is a command-oriented framework that treats commands,
subcommands, arguments, and options as first-class concepts.

You design commands declaratively.
Cardinal handles parsing, validation, and execution internally.

The underlying parser is an implementation detail.

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