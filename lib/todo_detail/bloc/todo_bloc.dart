import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_with_bloc/common/network_error.dart';
import 'package:json_with_bloc/todo_detail/data/model/todo_screen_model.dart';
import 'package:json_with_bloc/todo_detail/data/repositories/todo_screen_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoScreenRepo repository;

  TodoBloc({@required this.repository});

  @override
  TodoState get initialState => TodoLoading();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    try {
      if (event is GetAllTodos) {
        List<TodoScreenModel> todos = await repository.fetchSavedScreenTodos();
        if (todos.isNotEmpty) {
          print('loading saved todos');
          yield TodoLoaded(todos: todos);
        } else {
          List<TodoScreenModel> todos = await repository.fetchAllTodos();
          repository.saveScreenTodos(todos: todos);
          print('saving fetch todos');
          yield TodoLoaded(todos: todos);
        }
      } else if (event is GetUserTodos) {
        List<TodoScreenModel> todos =
            await repository.fetchAllUserTodos(userId: event.userId);
        yield TodoLoaded(todos: todos);
      } else {
        yield TodoLoadError('Undefined event occured.');
      }
    } on NetworkError {
      yield TodoLoadError(
          'Error occured while loading todos. Please try again.');
    }
  }
}
