import 'package:fastuserapp/src/models/vendor.dart';
import 'package:fastuserapp/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class BakeriesBloc {
  final _repo = Repository();

  final BehaviorSubject<List<Vendor>> _bakeriesSubject =
      BehaviorSubject<List<Vendor>>();
  Stream<List<Vendor>> get bakeries => _bakeriesSubject.stream;
  Function(List<Vendor>) get changeBakeries => _bakeriesSubject.sink.add;

  getBakeries() {
    _repo.getVendors("Bakery").listen(
      (bakeries) {
        changeBakeries(bakeries);
      },
    );
  }

  dispose() {
    _bakeriesSubject.close();
  }
}
