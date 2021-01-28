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
    // rating: json["rating"]??'',
    this.address = json["address"] ?? '';
    this.images = json['images'];
    this.imageUrl =getImageUrl() ;
    this.activeStatus = json["active_status"] ?? '';
    this.providerType =
        json["provider_type"] != null ? json["provider_type"]['name'] : '';
    this.state = json['state'] != null ? json['state']['name'] : '';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "rating": rating,
        "address": address,
        // "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "active_status": activeStatus,
        // "provider_type": providerType.toJson(),
        // "state": state.toJson(),
      };

  String getImageUrl() {
    String url = '';
    if (images.isNotEmpty&&images.first['formats']!=null &&images.first['formats']['large']!=null ) {
      url = images.first['formats']['large']['url'];
      print("MainImage: $url");
    }
    return url;
  }
}

class Image {
  Image({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.url,
    this.previewUrl,
    this.provider,
    this.providerMetadata,
    this.related,
  });

  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  Formats formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;
  String previewUrl;
  String provider;
  Formats providerMetadata;
  String related;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"] ?? '',
        name: json["name"],
        alternativeText: json["alternativeText"] ?? '',
        caption: json["caption"] ?? '',
        width: json["width"] ?? '',
        height: json["height"] ?? '',
        //formats: Formats.fromJson(json["formats"]),
        // hash: json["hash"],
        // ext: json["ext"],
        // mime: json["mime"],
        // size: json["size"],
        url: json["url"],
        // previewUrl: json["previewUrl"],
        // provider: json["provider"],
        // providerMetadata: Formats.fromJson(json["provider_metadata"]),
        // related: json["related"],
      );

// Map<String, dynamic> toJson() => {
//   "id": id,
//   "name": name,
//   "alternativeText": alternativeText,
//   "caption": caption,
//   "width": width,
//   "height": height,
//   "formats": formats.toJson(),
//   "hash": hash,
//   "ext": ext,
//   "mime": mime,
//   "size": size,
//   "url": url,
//   "previewUrl": previewUrl,
//   "provider": provider,
//   "provider_metadata": providerMetadata.toJson(),
//   "related": related,
// };
}

class Formats {
  Formats();

  factory Formats.fromJson(Map<String, dynamic> json) => Formats();

  Map<String, dynamic> toJson() => {};
}

class ProviderType {
  ProviderType({
    // this.id=1,
    this.name = '',
  });

  //int id;
  String name;

  factory ProviderType.fromJson(Map<String, dynamic> json) => ProviderType(
        // id: json["id"]??'',
        name: json["name"] ?? '',
      );

// Map<String, dynamic> toJson() => {
//   "id": id,
//   "name": name,
// };
}

// class ProvidersModel {
//   String id;
//   String type;
//   String providerName;
//   String activeStatus;
//   String providerDescription;
//   String rating;
//   String creationDate;
//   String address;
//   List imageList;
//   String typeName;
//   String typeId;
//   String stateId;
//   String stateName;
//   String imageUrl;
//
//   ProvidersModel(
//       {this.id='',
//       this.type='',
//       this.providerName='',
//       this.activeStatus,
//       this.providerDescription='',
//       this.rating='',
//       this.creationDate='',
//       this.address='',
//       this.typeName='',
//       this.typeId='',
//       this.imageList,
//       this.imageUrl='',
//       this.stateName=''});
//
//   ProvidersModel.fro(Map<String, dynamic> map) {
//     print("Image url: ${map['images']}");
//     id = map['id'] ?? '';
//     providerName = map['name'] ?? '';
//     providerDescription = map['description'] ?? '';
//     stateName = map['state']['name'] ?? '';
//     rating = map['rating'] ?? '';
//     address = map['address'] ?? '';
//     activeStatus = map['active_status'] ?? '';
//     typeId = map['provider_type']['id'] ?? '';
//     typeName = map['provider_type']['name'] ?? '';
//     creationDate = map['created_at'] ?? '';
//     //this.imageUrl = getImageUrl(map['images']);
//   }
//
//   String getImageUrl() {
//     String _imageUrl = '';
//     if (this.imageList.isNotEmpty && this.imageList != []) {
//       if (this.imageList.first['formats']['small']['url'] != null &&
//           this.imageList.first['formats']['small']['url'] != '') {
//         _imageUrl = this.imageList.first['formats']['small']['url'];
//       }
//       // print('First Image: ${list.first}');
//     }
//     return _imageUrl;
//   }
// }
