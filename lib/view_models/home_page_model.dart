import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prozone/models/providers_model.dart';

import '../helpers/http_helper.dart';

class HomePageModel with ChangeNotifier {
  Stream<List<ProvidersModel>> homePageModelStream() async* {
    final result = await HttpHelper.getAllProviders();
    final body = json.decode(result.body) as List<dynamic>;

    List<ProvidersModel> list = [];
    for (var mid in body) {
      list.add(ProvidersModel.fromJson(mid));
    }

    yield list;
  }
}
