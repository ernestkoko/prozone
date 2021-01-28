import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './new_provider_page.dart';
import '../models/providers_model.dart';
import '../pages/provider_details_page.dart';
import '../view_models/home_page_model.dart';

class HomePage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  // Widget appBarTitle = Text('ProZone');
  // Icon actionIcon = Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomePageModel>(context, listen: false);
    return WillPopScope(
      onWillPop:() async => showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text('Are you sure you want to quit?'), actions: <Widget>[
                RaisedButton(
                    child: Text('Yes'),
                    onPressed: () => Navigator.of(context).pop(true)),
                RaisedButton(
                    child: Text('No'),
                    onPressed: () => Navigator.of(context).pop(false)),
              ])),
      child: Scaffold(
        appBar: AppBar(
          title: Text("ProZone"),
        ),
        body: StreamBuilder(
          stream: model.homePageModelStream(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              final myData = snapshot.data as List<ProvidersModel>;

              final children = myData
                  .map((providerModel) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: providerModel.getImageUrl() == ''
                                ? Icon(
                                    Icons.account_circle_sharp,
                                    size: 40,
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(providerModel.getImageUrl()),
                                  ),
                            title: Text(
                                "${providerModel.name != '' ? providerModel.name : "No Name"}"),
                            subtitle: Text(
                                "${providerModel.providerType != '' ? providerModel.providerType : "No Type"}"),
                            trailing: Text(
                                '${providerModel.rating != null ? providerModel.rating : 'Not set'}'),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  ProviderDetailsPage.route,
                                  arguments: providerModel);
                            },
                          ),
                        ),
                      ))
                  .toList();

              return ListView(
                children: children,
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text("Some errors occurred"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(NewProviderPage.route);
          },
        ),
      ),
    );
  }
}
