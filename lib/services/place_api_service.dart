import 'package:dio/dio.dart';

import '../config/api_config.dart';
import '../models/place_model.dart';

class PlaceApiService {
  final Dio dio = Dio();

  Future<List<PlaceModel>> getPlaces(String city) async {
    final coordinates = _getCityCoordinates(city);

    try {
      final response = await dio.get(
        'https://api.geoapify.com/v2/places',
        queryParameters: {
          'categories': 'tourism',
          'filter':
              'circle:${coordinates['lon']},${coordinates['lat']},15000',
          'bias':
              'proximity:${coordinates['lon']},${coordinates['lat']}',
          'limit': 10,
          'lang': 'ar',
          'apiKey': ApiConfig.geoapifyKey,
        },
      );

      final List features = response.data['features'] ?? [];

      return features
          .map((place) => PlaceModel.fromJson(place))
          .where(
            (place) =>
                place.name.isNotEmpty &&
                place.name != 'مكان بدون اسم',
          )
          .toList();
    } catch (error) {
      throw Exception('تعذر تحميل الأماكن');
    }
  }

  Map<String, double> _getCityCoordinates(String city) {
    if (city == 'الرياض') {
      return {
        'lat': 24.7136,
        'lon': 46.6753,
      };
    }

    if (city == 'أبها') {
      return {
        'lat': 18.2164,
        'lon': 42.5053,
      };
    }

    return {
      'lat': 21.4858,
      'lon': 39.1925,
    };
  }
}