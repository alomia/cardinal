class CardinalConfig {
  final Map<String, dynamic> _values;

  CardinalConfig(this._values);

  T? get<T>(String key) {
    final value = _values[key];
    return value is T ? value : null;
  }

  String? string(String key) => get<String>(key);
  int? intValue(String key) => get<int>(key);
  bool? boolValue(String key) => get<bool>(key);
}
