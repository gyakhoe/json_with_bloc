import 'package:json_with_bloc/common/common_repo.dart';
import 'package:json_with_bloc/common/strings.dart';
import 'package:json_with_bloc/post_detail/data/models/post.dart';

class PostRepo {
  Future<List<Post>> fetchAllPost() async {
    var jsonReponse =
        await CommonRepo.makeHttpRequestForList(url: Strings.postsApiUrl);
    List<Post> posts = jsonReponse.map((e) => Post.fromMap(e)).toList();
    return posts;
  }

  Future<List<Post>> fetchUserPost({int userId}) async {
    var jsonResponse = await CommonRepo.makeHttpRequestForList(
        url: Strings.postsApiUrl, appendUrl: '?userId=$userId');
    List<Post> posts = jsonResponse.map((e) => Post.fromMap(e)).toList();
    return posts;
  }

  Future<Post> fetchPost({int postId}) async {
    var jsonResponse = await CommonRepo.makeHttpRequest(
        url: Strings.postsApiUrl, appendUrl: postId);
    Post post = Post.fromJson(jsonResponse);
    return post;
  }
}
