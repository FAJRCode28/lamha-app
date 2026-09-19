class PlaceModel {
  final String id;
  final String name;
  final String city;
  final String address;
  final double latitude;
  final double longitude;

  PlaceModel({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'];

    return PlaceModel(
      id: properties['place_id'] ?? '',
      name: properties['name'] ?? 'مكان بدون اسم',
      city: properties['city'] ?? '',
      address: properties['formatted'] ?? '',
      latitude: (properties['lat'] ?? 0).toDouble(),
      longitude: (properties['lon'] ?? 0).toDouble(),
    );
  }
}