part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
}

class GetPostComments extends CommentEvent {
  final int postId;
  GetPostComments(this.postId);
  @override
  List<Object> get props => [];
}
