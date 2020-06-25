import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_with_bloc/comment_detail/bloc/comment_bloc.dart';
import 'package:json_with_bloc/comment_detail/data/models/comment.dart';
import 'package:json_with_bloc/comment_detail/layout/widgets/comment_widget.dart';
import 'package:json_with_bloc/post_detail/data/models/post_screen_model.dart';
import 'package:json_with_bloc/post_detail/ui/widgets/post_widget.dart';

class CommentScreen extends StatelessWidget {
  final PostScreenModel postScreenModel;
  const CommentScreen({Key key, @required this.postScreenModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(children: <Widget>[
        PostWidget(
          postScreenModel: postScreenModel,
          shouldCommentButtonDisable: true,
        ),
        Container(
          height: MediaQuery.of(context).size.height - 169 - 85,
          child: BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentLoading) {
                return _loadingWidget(context, state.postId);
              } else if (state is CommentLoaded) {
                return _buildCommentList(state.comments);
              } else {
                return _undefinedStateWidget();
              }
            },
          ),
        ),
      ]),
    );
  }

  Widget _undefinedStateWidget() {
    return Center(
      child:
          Text('Unexpected error occured. Please try closing and openning app'),
    );
  }

  Widget _loadingWidget(BuildContext context, int postId) {
    context.bloc<CommentBloc>()..add(GetPostComments(postId));
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildCommentList(List<Comment> comments) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: comments.length,
      itemBuilder: (context, index) {
        Comment comment = comments.elementAt(index);
        return CommentWidget(comment: comment);
      },
    );
  }
}
