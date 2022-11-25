class CityModel {
  String? key;
  String? englishName;

  CityModel({this.key, this.englishName});

  CityModel.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    englishName = json['EnglishName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Key'] = key;
    data['EnglishName'] = englishName;
    return data;
  }
}
