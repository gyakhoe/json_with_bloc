import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_with_bloc/comment_detail/data/models/comment.dart';
import 'package:json_with_bloc/common/common_repo.dart';
import 'package:json_with_bloc/common/strings.dart';

class CommentRepo {
  Future<List<Comment>> fetchAllComments() async {
    var jsonResponse =
        await CommonRepo.makeHttpRequestForList(url: Strings.commentsApiUrl);
    List<Comment> comments =
        jsonResponse.map((e) => Comment.fromMap(e)).toList();
    return comments;
  }

  Future<List<Comment>> fetchPostComment({int postId}) async {
    var jsonResponse = await CommonRepo.makeHttpRequestForList(
        url: Strings.commentsApiUrl, appendUrl: '?postId=$postId');
    List<Comment> comments =
        jsonResponse.map((e) => Comment.fromMap(e)).toList();
    return comments;
  }

  Future<Comment> fetchComment({int commentId}) async {
    var jsonResponse = await CommonRepo.makeHttpRequest(
        url: Strings.albumsApiUrl, appendUrl: commentId);
    Comment comment = Comment.fromJson(jsonResponse);
    return comment;
  }

  Future<List<Comment>> fetchSavedPostComment(int postId) async {
    String savedJsonString = await CommonRepo.loadSavedJsonString(
        key: '${Strings.prefKeyComments}_$postId');
    return savedJsonString != null
        ? (json.decode(savedJsonString) as List)
            .map((e) => Comment.fromJson(e))
            .toList()
        : [];
  }

  void savePostComment(
      {@required int postId, @required List<Comment> comments}) {
    CommonRepo.saveObjects(
        key: '${Strings.prefKeyComments}_$postId', objects: comments);
  }
}
