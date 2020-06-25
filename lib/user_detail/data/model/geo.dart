import 'dart:convert';

class Geo {
  final String lat;
  final String lng;
  Geo({
    this.lat,
    this.lng,
  });

  Geo copyWith({
    String lat,
    String lng,
  }) {
    return Geo(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  static Geo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Geo(
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  static Geo fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Geo(lat: $lat, lng: $lng)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Geo && o.lat == lat && o.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
