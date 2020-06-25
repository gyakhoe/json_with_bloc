import 'package:flutter/material.dart';
import 'package:json_with_bloc/album_detail/data/model/album_screen_model.dart';

class AlbumWidget extends StatelessWidget {
  final AlbumScreenModel albumScreenModel;
  const AlbumWidget({
    Key key,
    @required this.albumScreenModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => FutureProvider(
        //       create: (context) => PhotoScreenProvider()
        //           .fetchAllPhotoOfAlbum(albumId: albumScreenModel.album.id),
        //       child: PhotoScreen(album: albumScreenModel.album),
        //     ),
        //   ),
        // );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 5,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 7,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage(albumScreenModel.firstPhtotUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(albumScreenModel.userProfilePhotoUrl),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(
                            text: albumScreenModel.album.title,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '\n${albumScreenModel.name}',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextSpan(
                            text: '\n@${albumScreenModel.username}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
