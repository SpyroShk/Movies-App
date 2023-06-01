import 'dart:convert';

class Runtime {
  int runtime;
  Runtime({
    required this.runtime,
  });

  factory Runtime.fromMap(Map<String, dynamic> map) {
    return Runtime(
      runtime: map['runtime'] as int,
    );
  }

  factory Runtime.fromJson(String source) =>
      Runtime.fromMap(json.decode(source));
}
