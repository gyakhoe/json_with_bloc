part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostLoading extends PostState {
  const PostLoading();
  @override
  List<Object> get props => [];
}

class PostLoaded extends PostState {
  final List<PostScreenModel> posts;
  const PostLoaded(this.posts);
  @override
  List<Object> get props => [posts];
}

class PostError extends PostState {
  final String message;
  const PostError(this.message);

  @override
  List<Object> get props => [message];
}
