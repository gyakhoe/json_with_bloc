import 'dart:convert';

import 'package:json_with_bloc/post_detail/data/models/post.dart';

class PostScreenModel {
  final String name;
  final String username;
  final String photoUrl;
  final Post post;

  PostScreenModel({
    this.name,
    this.username,
    this.photoUrl,
    this.post,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'photoUrl': photoUrl,
      'post': post?.toMap(),
    };
  }

  static PostScreenModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PostScreenModel(
      name: map['name'],
      username: map['username'],
      photoUrl: map['photoUrl'],
      post: Post.fromMap(map['post']),
    );
  }

  String toJson() => json.encode(toMap());

  static PostScreenModel fromJson(String source) =>
      fromMap(json.decode(source));
}
