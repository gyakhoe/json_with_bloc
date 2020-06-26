import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_with_bloc/common/strings.dart';
import 'package:json_with_bloc/common/widgets/common_widgets.dart';
import 'package:json_with_bloc/todo_detail/bloc/todo_bloc.dart';
import 'package:json_with_bloc/todo_detail/data/model/todo.dart';
import 'package:json_with_bloc/todo_detail/data/model/todo_screen_model.dart';
import 'package:json_with_bloc/todo_detail/data/repositories/todo_screen_repo.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(repository: TodoScreenRepoImpl()),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoading) {
              context.bloc<TodoBloc>().add(GetAllTodos());
              return CommonWidgets.buildLoadingIndicator();
            } else if (state is TodoLoaded) {
              return _buildTodoList(state.todos);
            } else {
              return CommonWidgets.buildUndefinedState();
            }
          },
        ),
      ),
    );
  }

  Widget _buildTodoList(List<TodoScreenModel> todos) {
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return _buildTodoItem(
            context: context,
            todoScreenModel: todos.elementAt(index),
          );
        });
  }

  Widget _buildTodoItem(
      {BuildContext context, TodoScreenModel todoScreenModel}) {
    Todo todo = todoScreenModel.todo;
    User user = todoScreenModel.user;
    return Card(
      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        Strings.userProfileImages.elementAt(user.id - 1)),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 5, left: 5),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: user.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: ' @${user.username}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5, left: 5),
                      child: Text(
                        todo.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: Center(
                  child: Checkbox(
                    value: todo.completed,
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
