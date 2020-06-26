import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_with_bloc/album_detail/bloc/album_bloc.dart';
import 'package:json_with_bloc/post_detail/bloc/post_bloc.dart';
import 'package:json_with_bloc/user_detail/layouts/user_album_screen.dart';
import 'package:json_with_bloc/user_detail/layouts/user_post_screen.dart';

class UserStatWidget extends StatelessWidget {
  final int userId;
  final String title;

  const UserStatWidget({
    Key key,
    @required this.userId,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return title == 'Post'
        ? _bluildPostStat(context)
        : _buildAlbumStat(context);
  }

  Widget _bluildPostStat(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          context.bloc<PostBloc>().add(GetuserPosts(userId));
          return _buildLoadingIndicator();
        } else if (state is UserPostLoaded) {
          return _buildCard(
              context: context,
              count: state.posts.length,
              nextPage: UserPostScreen(
                posts: state.posts,
              ));
        } else {
          return _buildUndefinedState();
        }
      },
    );
  }

  Widget _buildAlbumStat(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        if (state is AlbumLoading) {
          context.bloc<AlbumBloc>().add(GetUserAlbum(userId));
          return _buildLoadingIndicator();
        } else if (state is UserAlbumLoaded) {
          return _buildCard(
              context: context,
              count: state.albums.length,
              nextPage: UserAlbumScreen(
                albums: state.albums,
              ));
        } else {
          return _buildUndefinedState();
        }
      },
    );
  }

  Widget _buildCard(
      {@required BuildContext context,
      @required Widget nextPage,
      @required int count}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => nextPage));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                count != null
                    ? Text(
                        count.toString(),
                        style: TextStyle(fontSize: 50),
                      )
                    : CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _buildUndefinedState() {
    return Center(
        child: Icon(
      Icons.close,
      size: 50,
    ));
  }
}
