import 'dart:convert';

List<ProvidersModel> providersModelFromJson(String str) =>
    List<ProvidersModel>.from(
        json.decode(str).map((x) => ProvidersModel.fromJson(x)));

//String providersModelToJson(List<ProvidersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProvidersModel {
  ProvidersModel({
    this.id,
    this.name,
    this.description,
    this.rating,
    this.address,
    this.images,
    this.activeStatus,
    this.providerType,
    this.imageUrl,
    this.state,
  });

  int id;
  String name;
  String description;
  int rating;
  String address;
  String imageUrl;
  List images;
  String activeStatus;
  String providerType;
  String state;

  ProvidersModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"] ?? '';
    this.name = json["name"] ?? '';
    this.description = json["description"] ?? '';
    this.rating = json['rating'];
    this.address = json["address"] ?? '';
    this.images = json['images'];
    this.imageUrl = getImageUrl();
    this.activeStatus = json["active_status"] ?? '';
    this.providerType =
        json["provider_type"] != null ? json["provider_type"]['name'] : 'Not set';
    this.state = json['state']!=null? json['state']['name'] : 'Not set';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "rating": rating,
        "address": address,
        "active_status": activeStatus,
      };

  String getImageUrl() {
    String url = '';
    if (images.isNotEmpty &&
        images.first['formats'] != null &&
        images.first['formats']['large'] != null) {
      url = images.first['formats']['large']['url'];
      print("MainImage: $url");
    }
    return url;
  }
}
