import '../entities/category.dart';
import '../entities/district.dart';
import '../entities/place.dart';

abstract class PlacesRepository {
  Future<List<Place>> getPlaces({
    String? type,
    String? districtId,
    String? keyword,
    int page,
    int limit,
  });

  Future<Place?> getPlaceDetail(String id);
  Future<List<District>> getDistricts();
  Future<List<Category>> getCategories();
}
