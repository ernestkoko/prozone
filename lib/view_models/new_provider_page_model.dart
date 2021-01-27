import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:prozone/helpers/http_helper.dart';

class NewProviderPageModel with ChangeNotifier, HttpHelper {
  String id;
  String state;
  String providerName;
  String providerDescription;
  String providerAddress;
  String providerStatus;
  String typeId;
  String typeName;
  String imageUrl;
  bool isLoading;
  bool textEdited = false;
  bool submitted = false;

  NewProviderPageModel({
    this.id,
    this.state = '',
    this.providerName = '',
    this.providerDescription = '',
    this.providerAddress = '',
    this.providerStatus = '',
    this.typeId = '',
    this.typeName = '',

    this.imageUrl = '',
    this.isLoading = false,
    this.submitted = false,
    this.textEdited = false,
  });

  String get nameErrorMessage {
    String message = "Name of provider can not be empty";
    bool showError = submitted && providerName.isEmpty;
    return showError ? message : null;
  }

  String get addressErrorMessage {
    String message = "Address can not be empty";
    bool showError = submitted && providerAddress.isEmpty;
    return showError ? message : null;
  }

  String get descriptionErrorMessage {
    String message = "Description of provider can not be empty";
    bool showError = submitted && providerDescription.isEmpty;
    return showError ? message : null;
  }

  String get typeErrorMessage {
    String message = "Type of provider can not be empty";
    bool showError = submitted && typeName.isEmpty;
    return showError ? message : null;
  }

  String get stateErrorMessage {
    String message = "State of provider can not be empty";
    bool showError = submitted && state.isEmpty;
    return showError ? message : null;
  }

  bool get canSubmitForm {
    return state.isNotEmpty && typeName.isNotEmpty &&
        providerDescription.isNotEmpty && providerAddress.isNotEmpty  &&
        providerName.isNotEmpty;

  }

  void updateProviderName(String name) =>
      updateNewProviderPageModel(providerName: name, textEdited: true);

  void updateProviderAddress(String address) =>
      updateNewProviderPageModel(providerAddress: address, textEdited: true);

  void updateProviderDescription(String description) =>
      updateNewProviderPageModel(providerDescription: description, textEdited: true);

  void updateProviderState(String state) =>
      updateNewProviderPageModel(state: state, textEdited: true);

  void updateProviderType(String type) =>
      updateNewProviderPageModel(typeName: type, textEdited: true);

  void updateId(String id) => updateNewProviderPageModel(id: id, textEdited: true);

  Future<Response> registerProvider() async {
    updateNewProviderPageModel(isLoading: true, submitted: true);
    try {
      final result = await postProvider(
          name: this.providerName,
          address: this.providerAddress,
          description: this.providerDescription,
          state: this.state,
          type: this.typeName);


      return result;
    } catch (error) {
      print('PostProvider Error: $error');
      rethrow;
    } finally {
      updateNewProviderPageModel(isLoading: false);
    }
  }

  Future<Response> editProvider() async {
    updateNewProviderPageModel(isLoading: true, submitted: true);



    try {

      final result = updateProvider(
          id: id,
          name: providerName,
          desc: providerDescription,
          address: providerAddress,
          type: typeName,
          state: state);

      return result;
    } catch (error) {
      rethrow;
    } finally {
      updateNewProviderPageModel(isLoading: false);
    }
  }

  void updateNewProviderPageModel({String id,
    String state,
    String providerName,
    String providerDescription,
    String providerAddress,
    String providerStatus,
    String typeId,
    String typeName,
    String imageUrl,
    bool submitted,
    bool isLoading,
    bool textEdited,}) {
    this.id = id ?? this.id;
    this.state = state ?? this.state;
    this.providerName = providerName ?? this.providerName;
    this.providerDescription = providerDescription ?? this.providerDescription;
    this.providerAddress = providerAddress ?? this.providerAddress;
    this.providerStatus = providerStatus ?? this.providerStatus;
    this.typeId = typeId ?? this.typeId;
    this.typeName = typeName ?? this.typeName;
    this.imageUrl = imageUrl ?? this.imageUrl;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.textEdited = textEdited ?? this.textEdited;
    //notify listeners
    notifyListeners();
  }
}
