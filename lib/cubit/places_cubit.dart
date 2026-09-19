import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/place_api_service.dart';
import 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final PlaceApiService placeApiService;

  PlacesCubit(this.placeApiService) : super(PlacesInitial());

  Future<void> getPlaces(String city) async {
    emit(PlacesLoading());

    try {
      final places = await placeApiService.getPlaces(city);

      if (places.isEmpty) {
        emit(PlacesError('لم يتم العثور على أماكن'));
      } else {
        emit(PlacesSuccess(places));
      }
    } catch (error) {
      emit(PlacesError('حدث خطأ أثناء تحميل الأماكن'));
    }
  }
}