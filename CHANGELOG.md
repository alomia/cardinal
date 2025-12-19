## 0.3.0

### Breaking Changes
- Complete redesign of Cardinal’s core architecture.
- Previous command, context, and configuration APIs have been removed.
- Existing applications built on earlier versions will require migration.

### Added
- New declarative command system with first-class support for:
  - Typed arguments
  - Typed options
  - Flags
  - Subcommands
- Global options support shared across all commands.
- Context-driven execution model via `CardinalContext`.
- Clear separation between framework core and `args` integration.
- Improved and more accurate command usage output.

### Changed
- Simplified and flattened internal structure under `lib/src/`.
- Commands are now defined using a consistent declarative API.
- Argument and option parsing is centralized and type-safe.

### Removed
- Legacy internal modules and definitions.
- Old context and configuration abstractions.

### Fixed
- Improved validation and error reporting for missing required arguments.
- More predictable command and subcommand resolution.


## 0.2.0

- **Breaking Change:** Major internal refactoring of the project structure. All context classes have been moved to `lib/src/context/`.
- **New:** Introduced dedicated `lib/src/context` module for clearer separation of concerns.
- **Fix:** Updated dependency constraints in `pubspec.yaml`.
