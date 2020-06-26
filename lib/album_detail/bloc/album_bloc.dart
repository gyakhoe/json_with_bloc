import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_with_bloc/album_detail/data/model/album.dart';
import 'package:json_with_bloc/album_detail/data/model/album_screen_model.dart';
import 'package:json_with_bloc/album_detail/data/repositories/album_repo.dart';
import 'package:json_with_bloc/common/network_error.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepo albumRepo;

  AlbumBloc({@required this.albumRepo});

  @override
  AlbumState get initialState => AlbumLoading();

  @override
  Stream<AlbumState> mapEventToState(
    AlbumEvent event,
  ) async* {
    try {
      if (event is GetAllAlbums) {
        List<AlbumScreenModel> albums =
            await albumRepo.fetchSavedAlbumScreenDetails();
        if (albums.isNotEmpty) {
          yield AlbumLoaded(albums: albums);
        } else {
          albums = await albumRepo.fetchAllAlbumScreenDetail();
          albumRepo.saveAlbumScreenDetails(albums);
          yield AlbumLoaded(albums: albums);
        }
      } else if (event is GetUserAlbum) {
        List<Album> albums =
            await albumRepo.fetchUserAlbums(userId: event.userId);
        yield UserAlbumLoaded(albums: albums);
      }
    } on NetworkError {
      yield AlbumError('Failed to load Album');
    }
  }
}
