part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoLoading extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoaded extends TodoState {
  final List<TodoScreenModel> todos;
  TodoLoaded({
    @required this.todos,
  });

  @override
  List<Object> get props => [todos];
}

class TodoLoadError extends TodoState {
  final String errorMessage;
  TodoLoadError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class TodoCompeleted extends TodoState {
  final Todo todo;
  TodoCompeleted({@required this.todo});
  @override
  List<Object> get props => [todo];
}

class TodoIncompleted extends TodoState {
  final Todo todo;
  TodoIncompleted({@required this.todo});
  @override
  List<Object> get props => [todo];
}
