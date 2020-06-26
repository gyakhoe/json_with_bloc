import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_with_bloc/album_detail/data/model/album.dart';
import 'package:json_with_bloc/photo_detail/bloc/photo_bloc.dart';
import 'package:json_with_bloc/photo_detail/data/models/photo.dart';

class PhotoScreen extends StatelessWidget {
  final Album album;
  const PhotoScreen({
    Key key,
    @required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoLoading) {
            context.bloc<PhotoBloc>().add(GetAlbumPhotos(album.id));
            return _buildLoadingIndicator();
          } else if (state is PhotoLoaded) {
            return _buildPhotoGrid(photos: state.photos);
          } else {
            return _buildUndefinedState();
          }
        },
      ),
    );
  }

  Widget _buildUndefinedState() {
    return Center(
        child: Text(
            'Unexpected state. Please try closing and reopenning application.'));
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildPhotoGrid({@required List<Photo> photos}) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          Photo photo = photos.elementAt(index);
          return Card(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Image(
                image: NetworkImage(photo.thumbnailUrl),
                fit: BoxFit.contain,
              ),
            ),
          );
        });
  }
}
