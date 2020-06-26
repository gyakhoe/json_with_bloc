part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();
}

class GetAlbumPhotos extends PhotoEvent {
  final int albumId;

  GetAlbumPhotos(this.albumId);

  @override
  List<Object> get props => [albumId];
}
