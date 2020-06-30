part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class GetAllTodos extends TodoEvent {
  @override
  List<Object> get props => [];
}

class GetUserTodos extends TodoEvent {
  final int userId;
  GetUserTodos({@required this.userId});
  @override
  List<Object> get props => [userId];
}

class CompleteTodo extends TodoEvent {
  final Todo todo;
  CompleteTodo({@required this.todo});
  @override
  List<Object> get props => [todo];
}

class IncompleteTodo extends TodoEvent {
  final Todo todo;
  IncompleteTodo({@required this.todo});
  @override
  List<Object> get props => [todo];
}
