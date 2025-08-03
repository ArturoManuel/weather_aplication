import 'package:get/get.dart';
import 'dart:async';
import '../data/models/city_search_result.dart';
import '../data/repositories/weather_repository.dart';

class SearchController extends GetxController {
  final WeatherRepository _repository = Get.find();
  
  final _searchResults = <CitySearchResult>[].obs;
  final _isSearching = false.obs;
  final _searchQuery = ''.obs;
  
  Timer? _debounceTimer;
  
  List<CitySearchResult> get searchResults => _searchResults;
  bool get isSearching => _isSearching.value;
  String get searchQuery => _searchQuery.value;

  void searchCities(String query) {
    _searchQuery.value = query;
    _debounceTimer?.cancel();
    if (query.trim().isEmpty) {
      _searchResults.clear();
      return;
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    try {
      _isSearching.value = true;
      
      final results = await _repository.searchCities(query);
      _searchResults.value = results;
      
    } catch (e) {
      _searchResults.clear();
    } finally {
      _isSearching.value = false;
    }
  }

  void clearSearch() {
    _searchQuery.value = '';
    _searchResults.clear();
    _debounceTimer?.cancel();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}