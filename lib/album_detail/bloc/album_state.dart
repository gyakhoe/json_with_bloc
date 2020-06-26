part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();
}

class AlbumLoading extends AlbumState {
  AlbumLoading();
  @override
  List<Object> get props => [];
}

class AlbumError extends AlbumState {
  final String errorMessage;
  AlbumError(this.errorMessage);
  @override
  List<Object> get props => [];
}

class AlbumLoaded extends AlbumState {
  final List<AlbumScreenModel> albums;
  AlbumLoaded({@required this.albums});
  @override
  List<Object> get props => [];
}

class UserAlbumLoaded extends AlbumState {
  final List<Album> albums;
  UserAlbumLoaded({@required this.albums});
  @override
  List<Object> get props => [];
}
