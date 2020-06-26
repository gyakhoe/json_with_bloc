import 'package:flutter/material.dart';
import 'package:json_with_bloc/common/strings.dart';
import 'package:json_with_bloc/user_detail/data/model/user.dart';

import '../user_detail_screen.dart';

class UserWdiget extends StatelessWidget {
  final User user;

  const UserWdiget({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => UserDetailScreen(
                      user: user,
                    )));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 8,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      Strings.userProfileImages.elementAt(user.id - 1)),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('@${user.username}'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
