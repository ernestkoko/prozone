import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prozone/models/providers_model.dart';

import '../helpers/http_helper.dart';

class HomePageModel with ChangeNotifier {
  String name = '';

  set setName(String name) {
    print('Name: $name');
    this.name = name;
    notifyListeners();
  }

  Stream<List<ProvidersModel>> homePageModelStream() async* {
    final result = await HttpHelper.getAllProviders();
    final body = json.decode(result.body) as List<dynamic>;
    print('Name: $name');

    List<ProvidersModel> list = [];
    Map each;
    for (each in body) {

      list.add(ProvidersModel.fromJson(each));
    }

    yield list;
  }
}
