import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_with_bloc/comment_detail/bloc/comment_bloc.dart';
import 'package:json_with_bloc/comment_detail/data/repositories/comment_repo.dart';
import 'package:json_with_bloc/comment_detail/layout/comment_screen.dart';
import 'package:json_with_bloc/post_detail/data/models/post_screen_model.dart';

class PostWidget extends StatelessWidget {
  final PostScreenModel postScreenModel;
  final bool shouldCommentButtonDisable;
  const PostWidget({
    Key key,
    @required this.postScreenModel,
    this.shouldCommentButtonDisable: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 5),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(postScreenModel.photoUrl),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5, left: 5),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: postScreenModel.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' @${postScreenModel.username}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 78,
                padding: EdgeInsets.only(top: 5, left: 5),
                child: Text(
                  postScreenModel.post.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5, left: 5),
                width: MediaQuery.of(context).size.width - 78,
                child: Text(
                  postScreenModel.post.body,
                ),
              ),
              shouldCommentButtonDisable
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => CommentBloc(
                                  commentRepo: CommentRepo(),
                                  postId: postScreenModel.post.id,
                                ),
                                child: CommentScreen(
                                  postScreenModel: postScreenModel,
                                ),
                              ),
                            ));
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width - 78,
                          child: Center(
                            child: Text(
                              'Commnets',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          )),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
