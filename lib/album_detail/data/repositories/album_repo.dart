import 'dart:convert';

import 'package:json_with_bloc/album_detail/data/model/album.dart';
import 'package:json_with_bloc/album_detail/data/model/album_screen_model.dart';
import 'package:json_with_bloc/common/common_repo.dart';
import 'package:json_with_bloc/common/strings.dart';
import 'package:json_with_bloc/photo_detail/data/models/photo.dart';
import 'package:json_with_bloc/photo_detail/data/repositories/photo_repo.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';
import 'package:json_with_bloc/user_detail/data/repo/user_repo.dart';

class AlbumRepo {
  Future<List<Album>> fetchAllAlbums() async {
    var jsonRessponse =
        await CommonRepo.makeHttpRequestForList(url: Strings.albumsApiUrl);
    List<Album> albums = jsonRessponse.map((e) => Album.fromMap(e)).toList();
    return albums;
  }

  Future<List<Album>> fetchUserAlbums({int userId}) async {
    var jsonResponse = await CommonRepo.makeHttpRequestForList(
        url: Strings.albumsApiUrl, appendUrl: '?userId=$userId');
    List<Album> albums = jsonResponse.map((e) => Album.fromMap(e)).toList();
    return albums;
  }

  Future<Album> fetchAlbum({int albumId}) async {
    var jsonResponse = await CommonRepo.makeHttpRequest(
        url: Strings.albumsApiUrl, appendUrl: albumId);
    Album album = Album.fromJson(jsonResponse);
    return album;
  }

  Future<List<AlbumScreenModel>> fetchAllAlbumScreenDetail() async {
    List<Album> albums = await AlbumRepo().fetchAllAlbums();
    List<AlbumScreenModel> albumScreenModels = List<AlbumScreenModel>();
    for (Album album in albums) {
      User user = await UserRepo().fetchUserDetail(userId: album.userId);
      Photo photo = await PhotoRepo()
          .fetchPhotoWithCustomUrl(url: '${Strings.photosApiUrl}1/?albumId=1');
      AlbumScreenModel model = AlbumScreenModel(
          album: album,
          name: user.name,
          username: user.username,
          firstPhtotUrl: photo.thumbnailUrl,
          userProfilePhotoUrl:
              Strings.userProfileImages.elementAt(album.userId - 1));

      albumScreenModels.add(model);
    }
    return albumScreenModels;
  }

  void saveAlbumScreenDetails(List<AlbumScreenModel> albums) {
    CommonRepo().saveObjects(key: 'albums', objects: albums);
  }

  Future<List<AlbumScreenModel>> fetchSavedAlbumScreenDetails() async {
    String savedJsonString =
        await CommonRepo().loadSavedJsonString(key: 'albums');
    return savedJsonString != null
        ? (json.decode(savedJsonString) as List)
            .map((e) => AlbumScreenModel.fromJson(e))
            .toList()
        : [];
  }
}
