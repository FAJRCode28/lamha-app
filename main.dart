class Place {
  String name;
  String city;
  String crowdLevel;
  bool hasParking;
  String openingHours;

  Place(
    this.name,
    this.city,
    this.crowdLevel,
    this.hasParking,
    this.openingHours,
  );
}

void main() {
  Place place1 = Place(
    'Jeddah Waterfront',
    'Jeddah',
    'Busy',
    true,
    '4 PM - 12 AM',
  );

  Place place2 = Place(
    'Al Shallal Park',
    'Jeddah',
    'Medium',
    true,
    '5 PM - 1 AM',
  );

  Place place3 = Place(
    'Art Promenade',
    'Jeddah',
    'Quiet',
    false,
    '4 PM - 11 PM',
  );

  List<Place> places = [place1, place2, place3];

  for (var place in places) {
    print('Name: ' + place.name);
    print('City: ' + place.city);
    print('Crowd: ' + place.crowdLevel);
    print('Parking: ' + place.hasParking.toString());
    print('Opening Hours: ' + place.openingHours);
  }
}
