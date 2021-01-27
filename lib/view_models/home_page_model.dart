import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prozone/models/providers_model.dart';

import '../helpers/http_helper.dart';

class HomePageModel with ChangeNotifier {
  List<ProvidersModel> _providers = [];
  String name = '';

  List<ProvidersModel> get providers {
    print('Providers Length: ${_providers.length}');
    return [..._providers];
  }

  List<ProvidersModel> get typeAndOnBoardingStatus {
    print("typeAndOnBoarding Status called");
    // return [..._providers.where((provider) => provider.providerName.contains(name)).toList()];
  }

  Future<void> getProviders() async {
    try {
      print('ListSS; ');
      final result = await HttpHelper.getAllProviders();
    final  body = json.decode(result.body) as List;
    List<ProvidersModel> loaded =[];
    List.from(body).forEach((element) {
      // print("element: ${element['name']}");
      loaded.add(ProvidersModel(
        id: element['id'],
        providerName: element['name'],
        providerDescription: element['description'],
        address: element['address'],

      ));
     // print('element1: }');
    });

   // _providers=loaded;
      print("Result2: $body");
      notifyListeners();

    } catch (error) {
      rethrow;
    }
  }
}
