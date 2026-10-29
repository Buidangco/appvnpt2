import '../entities/place.dart';
import '../repositories/places_repository.dart';

class GetPlacesUseCase {
  const GetPlacesUseCase(this._repository);

  final PlacesRepository _repository;

  Future<List<Place>> call({
    String? type,
    String? districtId,
    String? keyword,
    int page = 1,
    int limit = 20,
  }) {
    return _repository.getPlaces(
      type: type,
      districtId: districtId,
      keyword: keyword,
      page: page,
      limit: limit,
    );
  }
}
