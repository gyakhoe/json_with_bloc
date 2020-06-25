import 'dart:convert';

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  Company copyWith({
    String name,
    String catchPhrase,
    String bs,
  }) {
    return Company(
      name: name ?? this.name,
      catchPhrase: catchPhrase ?? this.catchPhrase,
      bs: bs ?? this.bs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'catchPhrase': catchPhrase,
      'bs': bs,
    };
  }

  static Company fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Company(
      name: map['name'],
      catchPhrase: map['catchPhrase'],
      bs: map['bs'],
    );
  }

  String toJson() => json.encode(toMap());

  static Company fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'Company(name: $name, catchPhrase: $catchPhrase, bs: $bs)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Company &&
        o.name == name &&
        o.catchPhrase == catchPhrase &&
        o.bs == bs;
  }

  @override
  int get hashCode => name.hashCode ^ catchPhrase.hashCode ^ bs.hashCode;
}
