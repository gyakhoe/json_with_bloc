import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_with_bloc/common/network_error.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';
import 'package:json_with_bloc/user_detail/data/repositories/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo userRepo;

  UserBloc({@required this.userRepo});
  @override
  UserState get initialState => UserListLoading();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    try {
      if (event is GetAllUsers) {
        List<User> users = await userRepo.fetchAllUsers();
        yield UserListLoaded(users: users);
      }
    } on NetworkError {
      yield UserListLoadError('Error occured while loading the user list');
    }
  }
}
