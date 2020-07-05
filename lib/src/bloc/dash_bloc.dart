import 'package:fastuserapp/src/models/carousel_item.dart';
import 'package:fastuserapp/src/resources/repository.dart';

class DashBloc {
  final _repo = Repository();

  Stream<List<CarouselItem>> getCarouselItems() => _repo.getCarouselItems();
}
