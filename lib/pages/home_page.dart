import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './new_provider_page.dart';
import '../models/providers_model.dart';
import '../pages/provider_details_page.dart';
import '../view_models/home_page_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget appBarTitle = new Text(
    "ProZone",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = new TextEditingController();
  HomePageModel _model;

  List<String> _list;
  bool _IsSearching;
  String _searchText = "";

  _HomePageState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _model.setName = '';
          _searchText = "";
        });
      } else {
        setState(() {
          print('Name1: ${_searchController.text}');
          _IsSearching = true;
          _model.setName = _searchController.text;
          _searchText = _searchController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomePageModel>(context, listen: false);
    _model = model;
    return WillPopScope(
      onWillPop: () async => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: Text('Are you sure you want to quit?'),
                  actions: <Widget>[
                    RaisedButton(
                        child: Text('Yes'),
                        onPressed: () => Navigator.of(context).pop(true)),
                    RaisedButton(
                        child: Text('No'),
                        onPressed: () => Navigator.of(context).pop(false)),
                  ])),
      child: Scaffold(
        appBar: buildBar(context),
        body: StreamBuilder(
          stream: model.homePageModelStream(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              final myData = snapshot.data as List<ProvidersModel>;
              ProvidersModel pro;
              List<ProvidersModel> searchList=[];
              for(pro in myData){
                String name = pro.name.toLowerCase();
                String location =pro.providerType.toLowerCase();
                if(name.contains(_searchText.toLowerCase())|| location.contains(_searchText.toLowerCase())){
                  searchList.add(pro);
                }
              }


              final children = _searchText == ''
                  ? myData
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
                                        backgroundImage: NetworkImage(
                                            providerModel.getImageUrl()),
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
                      .toList()
                  : searchList
                      .map((providerModel) => Card(
                        child: ListTile(
                          leading: providerModel.getImageUrl() == ''
                              ? Icon(
                            Icons.account_circle_sharp,
                            size: 40,
                          )
                              : CircleAvatar(
                            backgroundImage: NetworkImage(
                                providerModel.getImageUrl()),
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

  Widget buildBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (this.actionIcon.icon == Icons.search) {
              this.actionIcon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _searchController,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Search with name",
                    hintStyle: new TextStyle(color: Colors.white)),
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "ProZone",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchController.clear();
    });
  }
}
