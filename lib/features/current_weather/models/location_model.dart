class LocationModel {
  String? name;
  double? latitude;
  double? longitude;
  String? country;
  String? state;

  LocationModel({
    this.name,
    this.latitude,
    this.longitude,
    this.country,
    this.state,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    latitude = json['lat'];
    longitude = json['lon'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['lat'] = latitude;
    data['lon'] = longitude;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}
