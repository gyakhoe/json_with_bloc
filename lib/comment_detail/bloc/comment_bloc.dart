import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_with_bloc/comment_detail/data/models/comment.dart';
import 'package:json_with_bloc/comment_detail/data/repositories/comment_repo.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepo commentRepo;
  final int postId;

  CommentBloc({
    @required this.postId,
    @required this.commentRepo,
  });

  @override
  CommentState get initialState => CommentLoading(postId);

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is GetPostComments) {
      try {
        List<Comment> comments =
            await commentRepo.fetchSavedPostComment(postId);
        if (comments.isNotEmpty) {
          yield CommentLoaded(comments);
        } else {
          comments = await commentRepo.fetchPostComment(postId: event.postId);
          commentRepo.savePostComment(postId: postId, comments: comments);
          yield CommentLoaded(comments);
        }
      } on CommentError {
        yield CommentError('Error occured while fetching post comments');
      }
    }
  }
}
