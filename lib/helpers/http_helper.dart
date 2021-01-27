import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Map<String, String> _getProvidersHeader = {
  HttpHeaders.contentTypeHeader: "application/json",
  HttpHeaders.acceptHeader: "application/json",
  HttpHeaders.authorizationHeader:
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjEwNzI4MTcxLCJleHAiOjE2MTMzMjAxNzF9.nNOF83M7U3Son7sgPOiDy73w5niGIi724A0QXEjzgTc"
};
final String baseUrl = "https://pro-zone.herokuapp.com";
enum Status { Pending, Active, Deleted }

class HttpHelper {
  static Future<http.Response> getAllProviders() async {
    try {
      final result =
          await http.get("$baseUrl/providers", headers: _getProvidersHeader);
      print('The result of getProviders: ${json.decode(result.body)}');

      return result;
    } catch (error) {
      print('The error is: $error');
      rethrow;
    }
  }

  Future<http.Response> postProvider(
      {String name,
      String type,
      String description,
      String address,
      String state}) async {
    try {
      final result = await http.post(
        "$baseUrl/providers",
        headers: _getProvidersHeader,
        body: jsonEncode({
          "name": name,
          "description": description,
          "rating": 3,
          "address": address,
          "active_status": 'Pending',
          "provider_type": "Gym",
          "state": state
        }),
      );
      print('postProvider result: ${json.decode(result.body)}');
      if (result.statusCode != 200) {
        String message = 'Something went wrong';
        if (result.statusCode == 500)
          message = 'An internal server error occurred';

        throw HttpException(message);
      }

      return result;
    } catch (error) {
      rethrow;
    }
  }

  Future<http.Response> updateProvider(
      {String id,
      String name,
      String desc,
      int rating,
      String address,
      String type,
      String state}) async {
    print('Id: $id');
    try {
      final result = await http.patch(
        "$baseUrl/providers/$id",
        headers: _getProvidersHeader,
        body: json.encode({
          "name": name,
          "description": desc,
          "rating": 0,
          "address": address,
          "active_status": "Pending",
          "provider_type": type,
          "state": state
        }),
      );
      print("Put result: ${json.decode(result.body)}");

      String message = "Something went wrong";
      if (result.statusCode == 404) {
        message = "Provider not found";
        throw HttpException(message);
      }
      if (result.statusCode == 500) {
        message = "An internal server error occurred";
        throw HttpException(message);
      }
      return result;
    } catch (error) {
      rethrow;
    }
  }
}
