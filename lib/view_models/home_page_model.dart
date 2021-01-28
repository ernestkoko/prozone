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

  // List<ProvidersModel> get typeAndOnBoardingStatus {
  //   print("typeAndOnBoarding Status called");
  //   return [
  //     ..._providers
  //         .where((provider) => provider.providerName.contains(name))
  //         .toList()
  //   ];
  // }

  Stream<List<ProvidersModel>> homePageModelStream() async* {
    final result = await HttpHelper.getAllProviders();
    final body = json.decode(result.body) as List<dynamic>;

    List<ProvidersModel> list=[];
    for(var mid in body){
      print('Each: $mid');
      list.add(ProvidersModel.fromJson(mid));
    }
    print("List of pro: $list");
    yield list;





  }

  // Future<void> getProviders() async {
  //   try {
  //     final result = await HttpHelper.getAllProviders();
  //     final body = json.decode(result.body) as List;
  //     List<ProvidersModel> loaded = [];
  //     // loaded = body
  //     //     .map((e) => ProvidersModel(id: e['id'], providerName: e['name']))
  //     //     .toList();
  //     body.forEach((element) {
  //       print("element: ${element['name']}");
  //       loaded.add(ProvidersModel(
  //           id: element['id'],
  //           providerName: element['name'],
  //           providerDescription: element['description'],
  //           address: element['address'],
  //           type: element['provider_type']['name'],
  //           stateName: element['state']['name']));
  //       // print('element1: }');
  //     });
  //
  //     _providers = loaded;
  //     // _providers=loaded;
  //     print("Result2: $body");
  //     // notifyListeners();
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
}
