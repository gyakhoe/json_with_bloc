import 'package:flutter/foundation.dart';
import 'package:json_with_bloc/common/common_repo.dart';
import 'package:json_with_bloc/common/strings.dart';
import 'package:json_with_bloc/todo_detail/data/model/todo.dart';

abstract class TodoApiRepo {
  Future<Todo> fetchTodoOnId({@required int todoId});
  Future<List<Todo>> fetchAllTodos();
  Future<List<Todo>> fetchUsersTodos({@required int userId});
  Future<List<Todo>> fetchTodosOnStatus({@required bool isCompleted});
  Future<List<Todo>> fetchUsersTodosOnStatus(
      {@required bool isCompleted, @required int userId});
}

class TodoApiRepoImpl implements TodoApiRepo {
  @override
  Future<List<Todo>> fetchAllTodos() async {
    var jsonReponse =
        await CommonRepo.makeHttpRequestForList(url: Strings.todosApiUrl);

    List<Todo> todos = jsonReponse.map((e) => Todo.fromMap(e)).toList();
    return todos;
  }

  @override
  Future<Todo> fetchTodoOnId({int todoId}) async {
    var response = await CommonRepo.makeHttpRequest(
        url: Strings.todosApiUrl, appendUrl: todoId);
    Todo todo = Todo.fromJson(response);
    return todo;
  }

  @override
  Future<List<Todo>> fetchTodosOnStatus({bool isCompleted}) async {
    var jsonResponse = await CommonRepo.makeHttpRequestForList(
        url: Strings.todosApiUrl, appendUrl: '?completed=$isCompleted');
    List<Todo> todos = jsonResponse.map((e) => Todo.fromMap(e)).toList();
    return todos;
  }

  @override
  Future<List<Todo>> fetchUsersTodos({int userId}) async {
    var jsonResponse = await CommonRepo.makeHttpRequestForList(
        url: Strings.todosApiUrl, appendUrl: '?userId=$userId');
    List<Todo> todos = jsonResponse.map((e) => Todo.fromMap(e)).toList();
    return todos;
  }

  @override
  Future<List<Todo>> fetchUsersTodosOnStatus(
      {bool isCompleted, int userId}) async {
    var response = await CommonRepo.makeHttpRequestForList(
        url: Strings.todosApiUrl,
        appendUrl: '?userId=$userId&completed=$isCompleted');
    List<Todo> todos = response.map((e) => Todo.fromMap(e)).toList();
    return todos;
  }
}
