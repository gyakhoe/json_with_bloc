import 'package:flutter/material.dart';
import 'package:json_with_bloc/album_detail/layout/album_page.dart';
import 'package:json_with_bloc/post_detail/ui/post_page.dart';
import 'package:json_with_bloc/user_detail/layouts/user_page.dart';
import 'common/application_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pages = [
    PostPage(),
    AlbumPage(),
    UserPage(),
  ];
  var pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON PlaceHolder'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () => showAboutDialog(
                context: context,
                applicationName: 'JsonPlaceHolder with Bloc',
                applicationIcon: ApplicationIcon(height: 80, width: 80),
                children: [
                  Text(
                    'This Application is developed using Flutter',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Developed by Gyague Sonam @gyakhoe from \"www.gyakhoe.com\"',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'The backend data is from \"http://jsonplaceholder.typicode.com\"',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'The user profile image is from \"https://unsplash.com"',
                  ),
                ]),
          )
        ],
      ),
      body: Center(child: pages[pageIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            title: Text('Post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            title: Text('Album'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('User'),
          ),
        ],
      ),
    );
  }
}
