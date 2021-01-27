import 'package:flutter/material.dart';

class EditProviderPage extends StatefulWidget {
  static final route = 'edit_provider_page';
  @override
  _EditProviderPageState createState() => _EditProviderPageState();
}

class _EditProviderPageState extends State<EditProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Provider'),),
    );
  }
}
