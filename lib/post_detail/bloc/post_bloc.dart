import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_with_bloc/post_detail/data/models/post.dart';
import 'package:json_with_bloc/post_detail/data/models/post_screen_model.dart';
import 'package:json_with_bloc/post_detail/data/repositories/post_detail_repo.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostDetailRepo repository;

  PostBloc(this.repository);

  @override
  PostState get initialState => PostLoading();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    try {
      if (event is GetAllPosts) {
        List<PostScreenModel> posts = await repository.fetchSavedPosts();
        if (posts != null && posts.isNotEmpty) {
          yield PostLoaded(posts);
        } else {
          List<PostScreenModel> postScreenModels =
              await repository.fetchAllPost();
          repository.savePosts(postScreenModels);
          yield PostLoaded(postScreenModels);
        }
      } else if (event is GetuserPosts) {
        List<Post> posts =
            await repository.fetchAllUserPost(userId: event.userId);
        yield UserPostLoaded(posts);
      }
    } on PostError {
      yield PostError('Error occured while fetching the post');
    }
  }
}
