import 'package:flutter/widgets.dart';
import 'package:tourism_app_flutter/data/api/api_service.dart';
import 'package:tourism_app_flutter/static/tourism_list_result_state.dart';

class TourismListProvider extends ChangeNotifier {

  final ApiServices _apiServices;

  TourismListProvider(
      this._apiServices,
      );

  TourismListResultState _resultState = TourismListNoneState();

  TourismListResultState get resultState => _resultState;

  Future<void> fetchTourismList() async {
    try {
      _resultState = TourismListLoadingState();
      notifyListeners();

      final result = await _apiServices.getTourismList();

      if (result.error) {
        _resultState = TourismListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = TourismListLoadedState(result.places);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = TourismListErrorState(e.toString());
      notifyListeners();
    }
  }
}
