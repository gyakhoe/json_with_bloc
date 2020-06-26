import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_with_bloc/album_detail/bloc/album_bloc.dart';
import 'package:json_with_bloc/album_detail/data/repositories/album_repo.dart';
import 'package:json_with_bloc/common/strings.dart';
import 'package:json_with_bloc/post_detail/bloc/post_bloc.dart';
import 'package:json_with_bloc/post_detail/data/repositories/post_detail_repo.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';
import 'package:json_with_bloc/user_detail/layouts/widgets/user_additional_detail_horizontal_widget.dart';
import 'package:json_with_bloc/user_detail/layouts/widgets/user_additional_detail_widget.dart';
import 'package:json_with_bloc/user_detail/layouts/widgets/user_stat_widget.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(Strings.userProfileImages
                                  .elementAt(user.id - 1)),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Name:  ${user.name}'),
                              Text('username:  ${user.username}'),
                              Text('Email: ${user.email}'),
                              Text('Phone: ${user.phone}'),
                              Text('web:   ${user.website}'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              UserAdditionalDetail(
                title: 'Address',
                children: <Widget>[
                  Text('Street  : ${user.address.street}'),
                  Text('Suite   : ${user.address.suite}'),
                  Text('city    : ${user.address.city}'),
                  Text('zipCode : ${user.address.zipcode}'),
                  Text(
                      'Geo      : lat: ${user.address.geo.lat}, long: ${user.address.geo.lng}'),
                ],
              ),
              UserAdditionalDetail(
                title: 'Company',
                children: <Widget>[
                  Text('name  : ${user.company.name}'),
                  Text('Catch Phrase   : ${user.company.catchPhrase}'),
                  Text('bs    : ${user.company.bs}'),
                ],
              ),
              UserAdditionalDetailHorizontalWidget(
                children: <Widget>[
                  BlocProvider(
                    create: (context) => PostBloc(PostScreenRepo()),
                    child: UserStatWidget(
                      userId: user.id,
                      title: 'Post',
                    ),
                  ),
                  BlocProvider(
                    create: (context) => AlbumBloc(albumRepo: AlbumRepo()),
                    child: UserStatWidget(
                      userId: user.id,
                      title: 'Album',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
