import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:json_with_bloc/common/network_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonRepo {
  static Future<List<dynamic>> makeHttpRequestForList(
      {@required String url, dynamic appendUrl}) async {
    appendUrl == null ? url = url : url = '$url${appendUrl.toString()}';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body) as List;
      return jsonResponse;
    } else {
      throw NetworkError('Error occured while making the request to $url');
    }
  }

  static Future<dynamic> makeHttpRequest({
    @required String url,
    dynamic appendUrl,
  }) async {
    appendUrl == null ? url = url : url = '$url${appendUrl.toString()}';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw NetworkError('Error occured while making the request to $url');
    }
  }

  void saveObjects({
    @required String key,
    @required List<dynamic> objects,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var postJsonString = json.encode(objects);
    prefs.setString(key, postJsonString);
  }

  Future<String> loadSavedJsonString({@required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
