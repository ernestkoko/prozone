import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prozone/models/providers_model.dart';
import 'package:prozone/pages/edit_provider_page.dart';
import 'package:prozone/pages/new_provider_page.dart';

class ProviderDetailsPage extends StatelessWidget {
  static final route = 'provider_details_page';

  @override
  Widget build(BuildContext context) {
    final pro = ModalRoute.of(context).settings.arguments as ProvidersModel;
   // print("Gotten pro: ${pro.imageList}");
    return Scaffold(
      appBar: AppBar(
      //  title: Text('${pro.providerName}'),
        actions: [
          FlatButton(onPressed: (){
            Navigator.of(context).pushNamed(NewProviderPage.route, arguments: pro);
          }, child: Text("Edit"))
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, top: 5, right: 10),
        child: ListView(children: [
          //listChild(context, 'Name', pro.providerName),
        //  listChild(context, 'Description', pro.providerDescription??''),
          listChild(context, 'Address', pro.address),
        ]),
      ),
    );
  }

  Widget listChild(BuildContext context, String name1, String name2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          color: Theme.of(context).accentColor.withOpacity(0.7),
          child: Text('$name1:'),
        ),
        Container(padding: EdgeInsets.all(10), child: Text(name2))
      ],
    );
  }
}
