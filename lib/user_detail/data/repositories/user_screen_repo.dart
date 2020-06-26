import 'dart:convert';

import 'package:json_with_bloc/common/common_repo.dart';
import 'package:json_with_bloc/common/strings.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';
import 'package:json_with_bloc/user_detail/data/repositories/user_repo.dart';

class UserScreenRepo implements UserRepo {
  Future<List<User>> fetchAllUsers() async {
    var jsonResponse =
        await CommonRepo.makeHttpRequestForList(url: Strings.usersApiUrl);
    List<User> users =
        jsonResponse.map((responseMap) => User.fromMap(responseMap)).toList();
    return users;
  }

  Future<User> fetchUserDetail({int userId}) async {
    var jsonResponse = await CommonRepo.makeHttpRequest(
        url: Strings.usersApiUrl, appendUrl: userId);
    User user = User.fromMap(jsonResponse);
    return user;
  }

  void saveUserDetail() async {}

  @override
  Future<List<User>> fetchSavedUsers() async {
    String savedJsonString =
        await CommonRepo.loadSavedJsonString(key: Strings.prefKeyUsers);
    return savedJsonString != null
        ? (jsonDecode(savedJsonString) as List)
            .map((e) => User.fromJson(e))
            .toList()
        : [];
  }

  @override
  void saveUserList({List<User> users}) {
    CommonRepo.saveObjects(key: Strings.prefKeyUsers, objects: users);
  }
}
