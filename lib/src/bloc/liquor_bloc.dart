import 'package:fastuserapp/src/models/liquor.dart';
import 'package:fastuserapp/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class LiquorBloc {
  final _repo = Repository();

  getLiquors(String category) => _repo.getLiquor(category);

  dispose() {}
}
