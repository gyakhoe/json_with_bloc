part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();
}

class PhotoLoading extends PhotoState {
  @override
  List<Object> get props => [];
}

class PhotoLoaded extends PhotoState {
  final List<Photo> photos;
  PhotoLoaded(this.photos);
  @override
  List<Object> get props => [photos];
}

class PhotoError extends PhotoState {
  final String errorMessage;
  PhotoError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
