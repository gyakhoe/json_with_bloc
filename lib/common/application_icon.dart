import 'package:flutter/material.dart';

class ApplicationIcon extends StatelessWidget {
  final double height;
  final double width;
  const ApplicationIcon({Key key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: height - 10,
            width: height - 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).accentColor,
            ),
          ),
          Container(
            height: height - 20,
            width: height - 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
              border: Border.all(
                color: Colors.pink,
              ),
            ),
            child: Center(
              child: Text(
                'GS',
                style: TextStyle(fontSize: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
