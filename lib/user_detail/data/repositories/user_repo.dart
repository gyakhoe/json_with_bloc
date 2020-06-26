import 'package:flutter/foundation.dart';

import 'package:json_with_bloc/user_detail/data/model/user.dart';

abstract class UserRepo {
  Future<List<User>> fetchAllUsers();
  Future<User> fetchUserDetail({int userId});
  void saveUserList({@required List<User> users});
  Future<List<User>> fetchSavedUsers();
}
