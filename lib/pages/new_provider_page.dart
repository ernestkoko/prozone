import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:prozone/models/providers_model.dart';
import 'package:prozone/view_models/new_provider_page_model.dart';

class NewProviderPage extends StatefulWidget {
  static final route = 'new_provider_page';
  final NewProviderPageModel model;

  const NewProviderPage({Key key, this.model}) : super(key: key);

  @override
  static Widget create() {
    return ChangeNotifierProvider<NewProviderPageModel>(
      create: (ctx) => NewProviderPageModel(),
      child: Consumer<NewProviderPageModel>(
        builder: (ctx, newProviderPageModel, child) => NewProviderPage(
          model: newProviderPageModel,
        ),
      ),
    );
  }

  _NewProviderPageState createState() => _NewProviderPageState();
}

class _NewProviderPageState extends State<NewProviderPage> {
  TextEditingController provNameController = TextEditingController();
  TextEditingController provIdController = TextEditingController();
  TextEditingController provDescriptionController = TextEditingController();
  TextEditingController provAddressController = TextEditingController();
  TextEditingController provStatusController = TextEditingController();
  TextEditingController provStateController = TextEditingController();
  TextEditingController provTypeNameController = TextEditingController();

  //focus nodes
  FocusNode provNameFocusNode = FocusNode();
  FocusNode provIdFocusNode = FocusNode();
  FocusNode provDescriptionFocusNode = FocusNode();
  FocusNode provAddressFocusNode = FocusNode();
  FocusNode provStatusFocusNode = FocusNode();
  FocusNode provStateNode = FocusNode();
  FocusNode provTypeNameFocusNode = FocusNode();

  NewProviderPageModel get model => widget.model;
  ProvidersModel _args;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    provNameController.dispose();
    provIdController.dispose();
    provDescriptionController.dispose();
    provAddressController.dispose();
    provStatusController.dispose();
    provStateController.dispose();
    provTypeNameController.dispose();
    //dispose the focus nodes
    provIdFocusNode.dispose();
    provNameFocusNode.dispose();
    provDescriptionFocusNode.dispose();
    provAddressFocusNode.dispose();
    provStatusFocusNode.dispose();
    provStateNode.dispose();
    provTypeNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProvidersModel args =
        ModalRoute.of(context).settings.arguments as ProvidersModel;
    _args = args;
    print("Args: ${args != null ? args.id : ''}");

    if (_args != null && !model.textEdited) {
      provNameController.text = _args.providerName;
      provAddressController.text = _args.address;
      provDescriptionController.text = _args.providerDescription;
      provTypeNameController.text = _args.typeName;
      provStateController.text = _args.stateName;

      //let the model be aware of the values of the text fields
      Future.delayed(Duration.zero, (){
        model.updateProviderName(_args.providerName);
        model.updateProviderAddress(_args.address);
        model.updateProviderDescription(_args.providerDescription);
        model.updateProviderType(_args.typeName);
        model.updateProviderState(_args.stateName);
        model.updateId(_args.id.toString());
      });

    }

    return Scaffold(
      appBar: AppBar(
        title: Text(args != null ? "Edit Provider" : 'Add Provider'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        children: [
          _buildProvName(),
          SizedBox(
            height: 10,
          ),
          _buildProvAddress(),
          SizedBox(
            height: 10,
          ),
          _buildProvDescription(),
          SizedBox(
            height: 10,
          ),
          _buildProvType(),
          SizedBox(
            height: 10,
          ),
          _buildProvState(),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: model.canSubmitForm ? registerOrEditProvider : null,
            child: model.isLoading
                ? CircularProgressIndicator()
                : Text(_args == null ? 'Register' : "Submit"),
          )
        ],
      ),
    );
  }

  void registerOrEditProvider() async {
    try {
      _args == null
          ? await model.registerProvider()
          : await model.editProvider();
    } catch (error) {
      print('My Error: $error');
      Fluttertoast.showToast(
          msg: 'Oops!  ${error.message}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
  }

  void _onEditingComplete(
      {FocusNode presentNode, FocusNode nextNode, String text}) {
    //check if the text is valid
    final focus = text.isNotEmpty ? nextNode : presentNode;
    //shift the focus
    FocusScope.of(context).requestFocus(focus);
  }

  TextField _buildProvName() {
    //returns a TextField
    return TextField(
      //set the controller
      controller: provNameController,
      focusNode: provNameFocusNode,
      //if true, the TextField is enabled
      enabled: model.isLoading == false,

      //InputDecoration
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_box_sharp),
        labelText: 'Provider Name',
        hintText: '',
        errorText: model.nameErrorMessage,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
      ),
      //fires every time the value in the TextField changes
      onChanged: model.updateProviderName,
      //makes the key board show numbers
      keyboardType: TextInputType.name,
      //makes the keyboard show the next button
      textInputAction: TextInputAction.next,
      //fires when the next button of the keyboard is tapped
      onEditingComplete: () {
        _onEditingComplete(
            presentNode: provNameFocusNode,
            nextNode: provAddressFocusNode,
            text: model.providerName);
      },
    );
  }

  TextField _buildProvAddress() {
    //returns a TextField
    return TextField(
      //set the controller
      controller: provAddressController,
      focusNode: provAddressFocusNode,
      //if true, the TextField is enabled
      enabled: model.isLoading == false,
      //InputDecoration
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.message),
        labelText: 'Address',
        hintText: '',
        errorText: model.addressErrorMessage,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
      ),
      //fires every time the value in the TextField changes
      onChanged: model.updateProviderAddress,
      //makes the key board show numbers
      keyboardType: TextInputType.streetAddress,
      //makes the keyboard show the next button
      textInputAction: TextInputAction.next,
      //fires when the next button of the keyboard is tapped
      onEditingComplete: () {
        _onEditingComplete(
            presentNode: provNameFocusNode,
            nextNode: provDescriptionFocusNode,
            text: model.providerName);
      },
    );
  }

  TextField _buildProvDescription() {
    //returns a TextField
    return TextField(
      //set the controller
      controller: provDescriptionController,
      focusNode: provDescriptionFocusNode,
      //if true, the TextField is enabled
      enabled: model.isLoading == false,
      //InputDecoration
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.description),
        labelText: 'Description',
        hintText: '',
        errorText: model.descriptionErrorMessage,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
      ),
      //fires every time the value in the TextField changes
      onChanged: model.updateProviderDescription,
      //makes the key board show numbers
      keyboardType: TextInputType.text,
      //makes the keyboard show the next button
      textInputAction: TextInputAction.next,
      //fires when the next button of the keyboard is tapped
      onEditingComplete: () {
        _onEditingComplete(
            presentNode: provDescriptionFocusNode,
            nextNode: provTypeNameFocusNode,
            text: model.providerName);
      },
    );
  }

  TextField _buildProvType() {
    //returns a TextField
    return TextField(
      //set the controller
      controller: provTypeNameController,
      focusNode: provTypeNameFocusNode,
      //if true, the TextField is enabled
      enabled: model.isLoading == false,
      //InputDecoration
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.business_center),
        labelText: 'Type',
        hintText: 'Gym',
        errorText: model.typeErrorMessage,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
      ),
      //fires every time the value in the TextField changes
      onChanged: model.updateProviderType,
      //makes the key board show numbers
      keyboardType: TextInputType.text,
      //makes the keyboard show the next button
      textInputAction: TextInputAction.next,
      //fires when the next button of the keyboard is tapped
      onEditingComplete: () {
        _onEditingComplete(
            presentNode: provTypeNameFocusNode,
            nextNode: provStateNode,
            text: model.providerName);
      },
    );
  }

  TextField _buildProvState() {
    //returns a TextField
    return TextField(
        //set the controller
        controller: provStateController,
        focusNode: provStateNode,
        //if true, the TextField is enabled
        enabled: model.isLoading == false,
        //InputDecoration
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          labelText: 'State',
          hintText: 'Lagos',
          errorText: model.stateErrorMessage,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
        ),
        //fires every time the value in the TextField changes
        onChanged: model.updateProviderState,
        //makes the key board show numbers
        keyboardType: TextInputType.text,
        //makes the keyboard show the next button
        textInputAction: TextInputAction.send,
        //fires when the next button of the keyboard is tapped
        onEditingComplete: model.canSubmitForm ? registerOrEditProvider : null);
  }
}
