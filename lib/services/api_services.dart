import 'dart:convert';
import 'package:get/get.dart';
import 'package:testimpack/models/user_details_model.dart';
import 'package:testimpack/models/user_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:testimpack/views/finished.dart';

class ApiServices {
  Future<List<UserList>> getListData() async {
    var request = http.Request('GET',
        Uri.parse('https://62d7c5f49c8b5185c77bada3.mockapi.io/activities'));

    http.StreamedResponse response = await request.send();
    var userData = await response.stream.bytesToString();
    var userDetails = jsonDecode(userData);

    if (response.statusCode == 200) {
      print(userDetails);
    } else {
      print(response.reasonPhrase);
    }

    return userListFromJson(userData);
  }

  Future<UserDetails> getIdData(String id) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://62d7c5f49c8b5185c77bada3.mockapi.io/activities/$id'));

    http.StreamedResponse response = await request.send();
    var userDetails = await response.stream.bytesToString();
    var userData = jsonDecode(userDetails);
    if (response.statusCode == 200) {
      print(userData);
    } else {
      print(response.reasonPhrase);
    }

    return userDetailsFromJson(userDetails);
  }

  Future<UserDetails> postActivities(
      String type, institution, obj, remark, when) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST',
        Uri.parse('https://62d7c5f49c8b5185c77bada3.mockapi.io/activities'));
    request.bodyFields = {
      'activityType': type,
      'institution': institution,
      'objective': obj,
      'remarks': remark,
      'when': when,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var userDetails = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Get.offAll(() => Finished());
    } else {
      Get.offAll(() => Finished());
    }

    return userDetailsFromJson(userDetails);
  }

  Future<UserDetails> editActivities(
      String id, type, institution, obj, remark, when) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://62d7c5f49c8b5185c77bada3.mockapi.io/activities/$id'));
    request.bodyFields = {
      'activityType': type,
      'institution': institution,
      'objective': obj,
      'remarks': remark,
      'when': when
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var userData = await response.stream.bytesToString();
    var userDEtails = jsonDecode(userData);

    if (response.statusCode == 200) {
      print(userDEtails);
      Get.to(() => Finished());
    } else {
      print(response.reasonPhrase);
    }

    return userDetailsFromJson(userData);
  }

  Future<UserDetails> completeActivities(String id) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://62d7c5f49c8b5185c77bada3.mockapi.io/activities/$id'));
    request.bodyFields = {'complete': '0'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var userData = await response.stream.bytesToString();
    var userDetails = jsonDecode(userData);

    if (response.statusCode == 200) {
      Get.to(Finished());
    } else {
      print(response.reasonPhrase);
    }

    return userDetailsFromJson(userData);
  }
}
