import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_with_bloc/common/widgets/common_widgets.dart';
import 'package:json_with_bloc/user_detail/bloc/user_bloc.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';
import 'package:json_with_bloc/user_detail/data/repositories/user_screen_repo.dart';
import 'package:json_with_bloc/user_detail/layouts/widgets/user_widget.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(userRepo: UserScreenRepo()),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserListLoading) {
              context.bloc<UserBloc>().add(GetAllUsers());
              return CommonWidgets.buildLoadingIndicator();
            } else if (state is UserListLoaded) {
              return _buildUsersGrid(users: state.users);
            } else {
              return CommonWidgets.buildUndefinedState();
            }
          },
        ),
      ),
    );
  }

  Widget _buildUsersGrid({@required List<User> users}) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          User user = users.elementAt(index);

          return UserWdiget(user: user);
        });
  }
}
