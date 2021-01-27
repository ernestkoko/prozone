class ProvidersModel {
  String id;
  String type;
  String providerName;
  String activeStatus;
  String providerDescription;
  String rating;
  String creationDate;
  String address;
  List imageList;
  String typeName;
  String typeId;
  String stateId;
  String stateName;
  String imageUrl;

  ProvidersModel(
      {this.id='',
      this.type='',
      this.providerName='',
      this.activeStatus,
      this.providerDescription='',
      this.rating='',
      this.creationDate='',
      this.address='',
      this.typeName='',
      this.typeId='',
      this.imageList,
      this.imageUrl='',
      this.stateName=''});

  ProvidersModel.fro(Map<String, dynamic> map) {
    print("Image url: ${map['images']}");
    id = map['id'] ?? '';
    providerName = map['name'] ?? '';
    providerDescription = map['description'] ?? '';
    stateName = map['state']['name'] ?? '';
    rating = map['rating'] ?? '';
    address = map['address'] ?? '';
    activeStatus = map['active_status'] ?? '';
    typeId = map['provider_type']['id'] ?? '';
    typeName = map['provider_type']['name'] ?? '';
    creationDate = map['created_at'] ?? '';
    //this.imageUrl = getImageUrl(map['images']);
  }

  String getImageUrl() {
    String _imageUrl = '';
    if (this.imageList.isNotEmpty && this.imageList != []) {
      if (this.imageList.first['formats']['small']['url'] != null &&
          this.imageList.first['formats']['small']['url'] != '') {
        _imageUrl = this.imageList.first['formats']['small']['url'];
      }
      // print('First Image: ${list.first}');
    }
    return _imageUrl;
  }
}
