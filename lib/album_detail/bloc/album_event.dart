part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();
}

class GetAllAlbums extends AlbumEvent {
  GetAllAlbums();
  @override
  List<Object> get props => [];
}
