import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:json_with_bloc/todo_detail/data/model/todo.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';

class TodoScreenModel {
  final User user;
  final Todo todo;

  TodoScreenModel({
    @required this.user,
    @required this.todo,
  });

  TodoScreenModel copyWith({
    User user,
    Todo todo,
  }) {
    return TodoScreenModel(
      user: user ?? this.user,
      todo: todo ?? this.todo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(),
      'todo': todo?.toMap(),
    };
  }

  static TodoScreenModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TodoScreenModel(
      user: User.fromMap(map['user']),
      todo: Todo.fromMap(map['todo']),
    );
  }

  String toJson() => json.encode(toMap());

  static TodoScreenModel fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => 'TodoScreenModel(user: $user, todo: $todo)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TodoScreenModel && o.user == user && o.todo == todo;
  }

  @override
  int get hashCode => user.hashCode ^ todo.hashCode;
}
