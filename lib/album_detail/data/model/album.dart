import 'dart:convert';

class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    this.userId,
    this.id,
    this.title,
  });

  Album copyWith({
    int userId,
    int id,
    String title,
  }) {
    return Album(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }

  static Album fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Album(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  static Album fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Album(userId: $userId, id: $id, title: $title)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Album && o.userId == userId && o.id == id && o.title == title;
  }

  @override
  int get hashCode => userId.hashCode ^ id.hashCode ^ title.hashCode;
}
