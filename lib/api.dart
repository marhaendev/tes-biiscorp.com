import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'data-login.dart';

class GetApi extends GetxController {
  static var page = "1".obs;
  final String urlUsers = 'https://reqres.in/api/users?page=';

  // users
  Future<List<dynamic>> fetchUsers() async {
    final String url = '$urlUsers${page.value}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) return json.decode(response.body)['data'];
    throw Exception('Failed to load data');
  }

  void next() {
    int currentPage = int.parse(page.value);
    page.value = (currentPage + 1).toString();
    update();
    print(page);
  }

  void back() {
    int currentPage = int.parse(page.value);
    if (currentPage > 1) {
      page.value = (currentPage - 1).toString();
      update();
      print(page);
    }
  }

  void reset() {
    page.value = 1.toString();
    update();
  }

  // login
  var isLoading = false.obs;
  var loginUser = "eve.holt@reqres.in".obs;
  var loginPass = "cityslicka".obs;
  var isSecure = false.obs;
  static var token = "";

  final String urlToken = 'https://reqres.in/api/login?token=$token';
  final String el = 'https://reqres.in/api/login';
  Future<void> login(String email, String password) async {
    isLoading.value = true;

    final response = await http.post(
      Uri.parse(el),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Get.snackbar('Login Success', 'Token: ${data['token']}');
      token = data['token'];
      Get.to(DataLoginPage());
    } else {
      Get.snackbar('Login Failed', 'Invalid email or password');
    }
  }

  final String urlDataLogin = 'https://reqres.in/api/login?page=';

  Future<List<dynamic>> fetchDataLogin() async {
    final String url = '$urlDataLogin${page.value}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) return json.decode(response.body)['data'];
    throw Exception('Failed to load data');
  }
}
