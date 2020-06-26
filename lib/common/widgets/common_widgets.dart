import 'package:flutter/material.dart';

class CommonWidgets {
  static Widget buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  static Widget buildUndefinedState() {
    return Center(
        child: Text(
            'Uh! Oh! Unexpected error occured while. Please try closing and openening application.'));
  }
}
