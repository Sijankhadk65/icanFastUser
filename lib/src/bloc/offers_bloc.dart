import 'package:fastuserapp/src/models/offers_item.dart';
import 'package:fastuserapp/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class OffersBloc {
  final _repo = Repository();

  final BehaviorSubject<List<OffersItem>> _offersSubject =
      BehaviorSubject<List<OffersItem>>();
  Stream<List<OffersItem>> get offers => _offersSubject.stream;
  Function(List<OffersItem>) get changeOffers => _offersSubject.sink.add;

  getOffers() {
    _repo.getSpecialOffers().listen((offers) {
      changeOffers(offers);
    });
  }

  dispose() {
    _offersSubject.close();
  }
}
