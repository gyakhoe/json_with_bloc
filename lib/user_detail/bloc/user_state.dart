part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserListLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserListLoaded extends UserState {
  final List<User> users;
  UserListLoaded({@required this.users});

  @override
  List<Object> get props => [];
}

class UserListLoadError extends UserState {
  final String errorMessage;
  UserListLoadError(this.errorMessage);
  @override
  List<Object> get props => [];
}
