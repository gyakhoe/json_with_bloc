import 'package:flutter/material.dart';
import 'package:json_with_bloc/post_detail/data/models/post.dart';

class UserPostScreen extends StatelessWidget {
  final List<Post> posts;
  const UserPostScreen({
    Key key,
    @required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            Post post = posts.elementAt(index);
            return Card(
              elevation: 5,
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              ),
            );
          }),
    );
  }
}
