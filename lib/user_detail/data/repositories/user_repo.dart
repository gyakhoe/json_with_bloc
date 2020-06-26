import 'package:json_with_bloc/common/common_repo.dart';
import 'package:json_with_bloc/common/strings.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';

class UserRepo {
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
}
