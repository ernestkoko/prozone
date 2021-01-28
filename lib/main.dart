import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/new_provider_page.dart';
import './pages/provider_details_page.dart';
import './view_models/home_page_model.dart';

import './pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageModel>(create: (ctx) => HomePageModel())
      ],
      child: MaterialApp(
        title: 'ProZone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: {
          ProviderDetailsPage.route: (ctx) => ProviderDetailsPage(),
          NewProviderPage.route: (ctx) => NewProviderPage.create(),
        },
      ),
    );
  }
}
