import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_with_bloc/album_detail/bloc/album_bloc.dart';
import 'package:json_with_bloc/album_detail/data/model/album_screen_model.dart';
import 'package:json_with_bloc/album_detail/layout/widgets/album_widget.dart';
import 'package:json_with_bloc/common/network_error.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        try {
          if (state is AlbumLoading) {
            return _buildLoadingWidget(context);
          } else if (state is AlbumLoaded) {
            return _buildAlubmGridView(albums: state.albums);
          } else {
            return _buildErrorWidget();
          }
        } on NetworkError {
          return _buildErrorWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    context.bloc<AlbumBloc>()..add(GetAllAlbums());
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorWidget() {
    return Center(child: Text('Error occured while fetching album values'));
  }

  Widget _buildAlubmGridView({@required List<AlbumScreenModel> albums}) {
    return GridView.builder(
        itemCount: albums.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          AlbumScreenModel albumScreenModel = albums.elementAt(index);
          return AlbumWidget(
            albumScreenModel: albumScreenModel,
          );
        });
  }
}
