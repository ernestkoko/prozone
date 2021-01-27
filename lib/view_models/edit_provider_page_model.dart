import 'package:flutter/foundation.dart';

class EditProviderPageModel with ChangeNotifier {
  String name,
      id,
      description,
      rating,
      activeStatus,
      providerType,
      state,
      address;

  EditProviderPageModel(
      {this.id,
      this.name,
      this.address,
      this.description,
      this.rating,
      this.activeStatus,
      this.providerType,
      this.state});

  void updateName(String name) => updateEditProviderPageModel(name: name);

  void updateDescription(String desc) =>
      updateEditProviderPageModel(description: desc);

  void updateRating(String string) =>
      updateEditProviderPageModel(rating: string);

  void updateActiveStatus(String status) =>
      updateEditProviderPageModel(activeStatus: status);

  void updateProviderType(String type) =>
      updateEditProviderPageModel(providerType: type);

  void updateAddress(String address) =>
      updateEditProviderPageModel(address: address);

  void updateState(String state) => updateEditProviderPageModel(state: state);
  void updateId(String id )=>updateEditProviderPageModel(id: id);

  void updateEditProviderPageModel({
    String id,
    String name,
    String description,
    String rating,
    String activeStatus,
    String providerType,
    String address,
    String state,
  }) {
    this.id = id ?? this.id;
    this.name = name ?? this.name;
    this.description = description ?? this.description;
    this.rating = rating ?? this.rating;
    this.activeStatus = activeStatus ?? this.activeStatus;
    this.providerType = providerType ?? this.providerType;
    this.address = address ?? this.address;
    this.state = state ?? this.state;

    notifyListeners();
  }
}
