import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'album.dart';

class AlbumScreenModel {
  final String userProfilePhotoUrl;
  final String name;
  final String username;
  final Album album;
  final String firstPhtotUrl;

  AlbumScreenModel({
    @required this.userProfilePhotoUrl,
    @required this.name,
    @required this.username,
    @required this.album,
    @required this.firstPhtotUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'userProfilePhotoUrl': userProfilePhotoUrl,
      'name': name,
      'username': username,
      'album': album?.toMap(),
      'firstPhtotUrl': firstPhtotUrl,
    };
  }

  static AlbumScreenModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AlbumScreenModel(
      userProfilePhotoUrl: map['userProfilePhotoUrl'],
      name: map['name'],
      username: map['username'],
      album: Album.fromMap(map['album']),
      firstPhtotUrl: map['firstPhtotUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  static AlbumScreenModel fromJson(String source) =>
      fromMap(json.decode(source));
}
