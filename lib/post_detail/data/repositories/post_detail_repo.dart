import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_with_bloc/common/common_repo.dart';
import 'package:json_with_bloc/common/strings.dart';
import 'package:json_with_bloc/post_detail/data/models/post.dart';
import 'package:json_with_bloc/post_detail/data/models/post_screen_model.dart';
import 'package:json_with_bloc/post_detail/data/repositories/post_repo.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';
import 'package:json_with_bloc/user_detail/data/repositories/user_repo.dart';
import 'package:json_with_bloc/user_detail/data/repositories/user_screen_repo.dart';

abstract class PostDetailRepo {
  Future<List<PostScreenModel>> fetchAllPost();
  Future<List<PostScreenModel>> fetchSavedPosts();
  void savePosts(List<PostScreenModel> posts);
  Future<List<Post>> fetchAllUserPost({@required int userId});
}

class PostScreenRepo implements PostDetailRepo {
  @override
  Future<List<PostScreenModel>> fetchAllPost() async {
    PostRepo postRepo = PostRepo();
    List<Post> posts = await postRepo.fetchAllPost();
    List<PostScreenModel> postScreenModels = List<PostScreenModel>();
    for (Post post in posts) {
      UserRepo userRepo = UserScreenRepo();
      User user = await userRepo.fetchUserDetail(userId: post.userId);
      PostScreenModel postScreenModel = PostScreenModel(
          post: post,
          name: user.name,
          username: user.username,
          photoUrl: Strings.userProfileImages.elementAt(post.userId - 1));
      postScreenModels.add(postScreenModel);
    }
    return postScreenModels;
  }

  void savePosts(List<PostScreenModel> posts) async {
    CommonRepo.saveObjects(key: Strings.prefKeyPosts, objects: posts);
  }

  Future<List<PostScreenModel>> fetchSavedPosts() async {
    String jsonString =
        await CommonRepo.loadSavedJsonString(key: Strings.prefKeyPosts);
    if (jsonString != null) {
      List<PostScreenModel> posts = (jsonDecode(jsonString) as List)
          .map((e) => PostScreenModel.fromJson(e))
          .toList();
      return posts;
    } else {
      return [];
    }
  }

  Future<List<Post>> fetchAllUserPost({@required int userId}) async {
    PostRepo postRepo = PostRepo();
    List<Post> posts = await postRepo.fetchUserPost(userId: userId);
    return posts;
  }
}
