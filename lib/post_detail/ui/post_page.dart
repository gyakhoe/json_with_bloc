import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_with_bloc/post_detail/bloc/post_bloc.dart';
import 'package:json_with_bloc/post_detail/data/models/post_screen_model.dart';
import 'package:json_with_bloc/post_detail/data/repositories/post_detail_repo.dart';

import 'widgets/post_widget.dart';

class PostPage extends StatelessWidget {
  PostPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(PostScreenRepo()),
      child: Container(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return _buildLoadingIndicator(context, state);
            } else if (state is PostLoaded) {
              return _postDetailList(posts: state.posts);
            } else {
              return Center(
                  child: Text(
                      'Uh! Oh! Please try closing and opening applicatin again.'));
            }
          },
        ),
      ),
    );
  }

  Widget _postDetailList({
    @required List<PostScreenModel> posts,
  }) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostWidget(
          postScreenModel: posts.elementAt(index),
        );
      },
    );
  }

  Widget _buildLoadingIndicator(BuildContext context, PostState state) {
    context.bloc<PostBloc>()..add(GetAllPosts());
    return Center(child: CircularProgressIndicator());
  }
}
