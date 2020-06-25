part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentLoading extends CommentState {
  final int postId;
  CommentLoading(this.postId);

  @override
  List<Object> get props => [];
}

class CommentLoaded extends CommentState {
  final List<Comment> comments;
  CommentLoaded(this.comments);
  @override
  List<Object> get props => comments;
}

class CommentError extends CommentState {
  final String errorMessage;
  CommentError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
