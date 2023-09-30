import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_task/Model/profile.dart';
import 'package:flutter_task/Network/apiConstant.dart';
import 'package:http/http.dart' as http;


class ApiService {
  Future<String?> getDogImage() async {
    try {
      var url = Uri.parse(ApiConstants.imgBaseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }
  Future<Profile?> getProfile() async {
    try {
      var url = Uri.parse(ApiConstants.profileBaseUrl + ApiConstants.profileEndpoint);
      var response = await http.get(url);
      myLongPrint("--->Response ${response.body}");
      if (response.statusCode == 200) {
        Profile profile = profileFromJson(response.body);
        return profile;
      }else{
        debugPrint("profile return null ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log( "Error --> ${e.toString()}");
    }
    return null;
  }
}
void myLongPrint(input) {
  String str = input.toString();

  // print out each chunk of 1000 characters sequentially
  while (str.length > 1000) {
    debugPrint(str.substring(0, 1000));

    // remove the first 1000 characters
    str = str.substring(1000);
  }

  // print the remaining characters
  debugPrint(str);
}
