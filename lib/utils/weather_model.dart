class ApiResponse {
  Location? location;
  Current? current;

  ApiResponse({this.location, this.current});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      current: json['current'] != null ? Current.fromJson(json['current']) : null,
    );
  }
}

class Location {
  String? name;
  String? country;
  String? localtime;

  Location({this.name, this.country, this.localtime});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      country: json['country'],
      localtime: json['localtime'],
    );
  }
}

class Current {
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windMph;
  double? precipMm;
  int? humidity;
  int? cloud;
  double? uv;

  Current({
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.precipMm,
    this.humidity,
    this.cloud,
    this.uv,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json['temp_c']?.toDouble(),
      tempF: json['temp_f']?.toDouble(),
      isDay: json['is_day'],
      condition: json['condition'] != null ? Condition.fromJson(json['condition']) : null,
      windMph: json['wind_mph']?.toDouble(),
      precipMm: json['precip_mm']?.toDouble(),
      humidity: json['humidity'],
      cloud: json['cloud'],
      uv: json['uv']?.toDouble(),
    );
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }
}
