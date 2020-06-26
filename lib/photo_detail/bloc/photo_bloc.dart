import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_with_bloc/common/network_error.dart';
import 'package:json_with_bloc/photo_detail/data/models/photo.dart';
import 'package:json_with_bloc/photo_detail/data/repositories/photo_repo.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepo photoRepo;

  PhotoBloc(this.photoRepo);

  @override
  PhotoState get initialState => PhotoLoading();

  @override
  Stream<PhotoState> mapEventToState(
    PhotoEvent event,
  ) async* {
    try {
      if (event is GetAlbumPhotos) {
        List<Photo> photos =
            await photoRepo.fetchSavedAlbumPhotos(albumId: event.albumId);
        if (photos.isNotEmpty) {
          print('Returing saved photos for album ID : ${event.albumId}');
          yield PhotoLoaded(photos);
        } else {
          photos =
              await photoRepo.fetchAlbumPhotoDetail(albumId: event.albumId);
          print('Saving photos of album ID ${event.albumId}');
          photoRepo.saveAlbumPhotoDetails(
              photos: photos, albumId: event.albumId);
          yield PhotoLoaded(photos);
        }
      }
    } on NetworkError {
      yield PhotoError('Error occured while fetching album Photos');
    }
  }
}
