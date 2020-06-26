import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_with_bloc/common/strings.dart';
import 'package:json_with_bloc/post_detail/data/models/post.dart';
import 'package:json_with_bloc/post_detail/data/models/post_screen_model.dart';
import 'package:json_with_bloc/post_detail/data/repositories/post_repo.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';
import 'package:json_with_bloc/user_detail/data/repositories/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostDetailRepo {
  Future<List<PostScreenModel>> fetchAllPost();
}

class PostScreenRepo implements PostDetailRepo {
  @override
  Future<List<PostScreenModel>> fetchAllPost() async {
    PostRepo postRepo = PostRepo();
    List<Post> posts = await postRepo.fetchAllPost();
    List<PostScreenModel> postScreenModels = List<PostScreenModel>();
    for (Post post in posts) {
      UserRepo userRepo = UserRepo();
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

  void savePostList(List<PostScreenModel> posts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var postJsonString = json.encode(posts);
    prefs.setString('post_detail', postJsonString);
  }

  Future<List<PostScreenModel>> getSavedPostDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('post_detail')) {
      List<PostScreenModel> posts =
          (json.decode(prefs.getString('post_detail')) as List)
              .map((e) => PostScreenModel.fromJson(e))
              .toList();
      return posts;
    }
    return null;
  }

  Future<List<Post>> fetchAllUserPost({@required int userId}) async {
    PostRepo postRepo = PostRepo();
    List<Post> posts = await postRepo.fetchUserPost(userId: userId);
    return posts;
  }
}
