import 'package:flutter/material.dart';

class UserAdditionalDetailHorizontalWidget extends StatelessWidget {
  final List<Widget> children;
  const UserAdditionalDetailHorizontalWidget({Key key, @required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }
}
