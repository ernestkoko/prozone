import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prozone/models/providers_model.dart';
import 'package:prozone/pages/provider_details_page.dart';

import './new_provider_page.dart';
import '../view_models/home_page_model.dart';

class HomePage extends StatelessWidget {
  bool searchHasText = false;
  bool _isSearching = false;
  TextEditingController searchController = TextEditingController();
  String _searchText = "";
  Widget appBarTitle = Text('ProZone');
  Icon actionIcon = Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomePageModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("ProZone"),
      ),
      body: StreamBuilder(
        stream: model.homePageModelStream(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final myData = snapshot.data as List<ProvidersModel>;
            print('Data : $myData');

            final children = myData.map((providerModel) {
              print('ImageUrl: ${providerModel.imageUrl}');

              return Card(
                child: ListTile(
                  leading: providerModel.images == []
                      ? Icon(Icons.account_circle_sharp)
                      : CircleAvatar(
                          backgroundImage: NetworkImage(providerModel.getImageUrl()),
                        ),
                  title: Text("Name: ${providerModel.name}"),
                  subtitle: Text("Type: ${providerModel.providerType}"),
                  onTap: (){
                    Navigator.of(context).pushNamed(ProviderDetailsPage.route,arguments: providerModel
                             );
                  },
                ),
              );
            }).toList();

            return ListView(
              children: children,
            );
          }

          if (snapshot.hasError) {
            print('Stream error: ${snapshot.error}');

            return Center(
              child: Text("Some errors occurred"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // body: FutureBuilder(
      //   future:
      //       Provider.of<HomePageModel>(context, listen: false).getProviders(),
      //   builder: (ctx, snapshot) =>
      //       snapshot.connectionState == ConnectionState.waiting
      //           ? Center(
      //               child: CircularProgressIndicator(),
      //             )
      //           : Consumer<HomePageModel>(
      //               builder: (ctx, model, child) => model.providers.length <= 0
      //                   ? child
      //                   : ListView.builder(
      //                       itemCount: model.providers.length,
      //                       itemBuilder: (ctx, index) {
      //                         return _listItem(index, model, context);
      //                       }),
      //               child: Center(
      //                 child: Text('Nothing to display'),
      //               ),
      //             ),
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(NewProviderPage.route);
        },
      ),
    );
  }

  Widget _listItem(int index, HomePageModel model, BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
            // leading: model.providers[index].getImageUrl() != ''
            //     ? CircleAvatar(
            //         backgroundImage:
            //             NetworkImage(model.providers[index].getImageUrl()),
            //         // child: Image.network(
            //         //   ,
            //         //
            //         // ),
            //       )
            //     : Icon(Icons.account_circle_sharp),
            // title: Text("Name: ${model.providers[index].providerName}"),
            // subtitle: Text('Type: ${model.providers[index].typeName}'),
            // onTap: () {
            //   print('ImageUrl: ${model.providers[index].getImageUrl()}');
            //   Navigator.of(context).pushNamed(ProviderDetailsPage.route,
            //       arguments: model.providers[index]);
            // },
            ),
      ),
    );
  }

// void _handleSearchStart() {
//   setState(() {
//     _isSearching = true;
//   });
// }

// void _handleSearchEnd() {
//   setState(() {
//     this.actionIcon = new Icon(
//       Icons.search,
//       color: Colors.white,
//     );
//     this.appBarTitle = new Text(
//       "ProZone",
//       style: new TextStyle(color: Colors.white),
//     );
//     _isSearching = false;
//     searchController.clear();
//   });
// }

}
