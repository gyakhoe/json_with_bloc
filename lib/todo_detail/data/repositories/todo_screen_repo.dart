import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_with_bloc/common/common_repo.dart';
import 'package:json_with_bloc/common/strings.dart';
import 'package:json_with_bloc/todo_detail/data/model/todo.dart';
import 'package:json_with_bloc/todo_detail/data/model/todo_screen_model.dart';
import 'package:json_with_bloc/todo_detail/data/repositories/todo_api_repo.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';
import 'package:json_with_bloc/user_detail/data/repositories/user_screen_repo.dart';

abstract class TodoScreenRepo {
  Future<List<TodoScreenModel>> fetchAllTodos();
  Future<List<TodoScreenModel>> fetchAllUserTodos({@required int userId});

  void saveScreenTodos(List<TodoScreenModel> todos);
  Future<List<TodoScreenModel>> fetchSavedScreenTodos();

  Future<List<TodoScreenModel>> fetchSavedUserScreenTodos({
    @required int userId,
  });
  void saveUserScreenTodos({
    @required List<TodoScreenModel> todos,
    @required int userId,
  });
}

class TodoScreenRepoImpl implements TodoScreenRepo {
  @override
  Future<List<TodoScreenModel>> fetchAllTodos() async {
    final List<TodoScreenModel> screenTodos = List<TodoScreenModel>();
    TodoApiRepo todoRepo = TodoApiRepoImpl();
    final List<Todo> todos = await todoRepo.fetchAllTodos();
    User user = User();
    for (Todo todo in todos) {
      if (user.id != todo.userId) {
        print(
            'user id didn\'t matched. So fetch the new user of ID ${todo.userId}');
        user = await UserScreenRepo().fetchUserDetail(userId: todo.userId);
      }
      TodoScreenModel todoScreenModel = TodoScreenModel(
        todo: todo,
        user: user,
      );
      screenTodos.add(todoScreenModel);
    }
    return screenTodos;
  }

  @override
  Future<List<TodoScreenModel>> fetchAllUserTodos(
      {@required int userId}) async {
    final List<TodoScreenModel> screenTodos = List<TodoScreenModel>();
    TodoApiRepo todoRepo = TodoApiRepoImpl();
    final List<Todo> todos = await todoRepo.fetchUsersTodos(userId: userId);
    User user = User();
    for (Todo todo in todos) {
      if (user.id != todo.userId) {
        print(
            'user id didn\'t matched. So fetch the new user of ID ${todo.userId}');
        user = await UserScreenRepo().fetchUserDetail(userId: todo.userId);
      }
      TodoScreenModel todoScreenModel = TodoScreenModel(
        todo: todo,
        user: user,
      );
      screenTodos.add(todoScreenModel);
    }
    return screenTodos;
  }

  @override
  Future<List<TodoScreenModel>> fetchSavedScreenTodos() async {
    String jsonString =
        await CommonRepo.loadSavedJsonString(key: Strings.prefKeyTodos);
    return jsonString != null
        ? (jsonDecode(jsonString) as List)
            .map((e) => TodoScreenModel.fromJson(e))
            .toList()
        : [];
  }

  @override
  void saveScreenTodos(List<TodoScreenModel> todos) {
    CommonRepo.saveObjects(key: Strings.prefKeyTodos, objects: todos);
  }

  @override
  Future<List<TodoScreenModel>> fetchSavedUserScreenTodos(
      {@required int userId}) async {
    String jsonString = await CommonRepo.loadSavedJsonString(
        key: '${Strings.prefKeyTodos}_$userId');

    return jsonString != null
        ? (jsonDecode(jsonString) as List)
            .map((e) => TodoScreenModel.fromJson(e))
            .toList()
        : [];
  }

  @override
  void saveUserScreenTodos({
    @required List<TodoScreenModel> todos,
    @required int userId,
  }) {
    CommonRepo.saveObjects(
        key: '${Strings.prefKeyTodos}_$userId', objects: todos);
  }
}
