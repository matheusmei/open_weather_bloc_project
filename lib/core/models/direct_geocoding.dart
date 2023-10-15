import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;
  DirectGeocoding({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

    Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
    };
  }

factory DirectGeocoding.fromJson(List<dynamic> jsonList) {
  final Map<String, dynamic> data = jsonList[0];

  return DirectGeocoding(
    name: data['name'],
    lat: data['lat'].toDouble(),
    lon: data['lon'].toDouble(),
    country: data['country'],
  );
}

  @override
  List<Object> get props => [name, lat, lon, country];

  @override
  String toString() {
    return 'DirectGeocoding(name: $name, lat: $lat, lon: $lon, country: $country)';
  }
}
