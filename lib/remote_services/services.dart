import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;
import '/model/person.dart';
import 'package:http/http.dart' as http;

class Services extends GetConnect {
  Future<List<Person>?> getPersons() async {
    http.Response response = await http.get(
      Uri.parse('http://falaknazdevcll.softologics.com/API/Users/all'),
      headers: {'x-api-key': '2eJUiqVPewyl3FC2wDXEkw=='},
    ).catchError((e) {
      log('$e');
    });
    if (response.statusCode == 200) {
      var a = jsonDecode(response.body);
      return List.from(a).map((e) => Person.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> addPerson(name, email, username, password) async {
    var response = await http.post(
      Uri.parse('http://falaknazdevcll.softologics.com/API/Users/add'),
      body: {
        "name": "$name",
        "email": "$email",
        "username": "$username",
        "password": "$password",
      },
      headers: {
        'NOAUTH': '1',
        'x-api-key': '2eJUiqVPewyl3FC2wDXEkw==',
      },
    );
    print('person_added ${response.body} ${response.statusCode}');
    if (response.statusCode == 200) {
      print('status code 200');
    } else {}
  }

  Future<void> updatePerson(name, email, username, password, userId) async {
    var response = await http.post(
      Uri.parse('http://falaknazdevcll.softologics.com/API/Users/update'),
      body: {
        "name": "$name",
        "email": "$email",
        "username": "$username",
        "password": "$password",
        "userid": "$userId",
      },
      headers: {
        'NOAUTH': '1',
        'x-api-key': '2eJUiqVPewyl3FC2wDXEkw==',
      },
    );
    print('updated ${response.body} ${response.statusCode}');
    if (response.statusCode == 200) {
      print('status code 200');
    } else {}
  }
}
