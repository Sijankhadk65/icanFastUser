import 'package:fastuserapp/src/models/vendor.dart';
import 'package:fastuserapp/src/resources/repository.dart';
import 'package:rxdart/subjects.dart';

class SearchBloc {
  final _repo = Repository();

  final BehaviorSubject<String> _searchFilterSubject =
      BehaviorSubject<String>();
  Stream<String> get searchFilter => _searchFilterSubject.stream;
  Function(String) get changeSearchFilter => _searchFilterSubject.sink.add;

  final BehaviorSubject<String> _querySubject = BehaviorSubject<String>();
  Stream<String> get query => _querySubject.stream;
  Function(String) get changeQuery => _querySubject.sink.add;

  final BehaviorSubject<List<Vendor>> _queryVendorsSubject =
      BehaviorSubject<List<Vendor>>();
  Stream<List<Vendor>> get queryVendors => _queryVendorsSubject.stream;
  Function(List<Vendor>) get changeQueryVendors =>
      _queryVendorsSubject.sink.add;

  SearchBloc() {
    changeSearchFilter("resturant");
    searchFilter.listen((filter) {
      if (filter == "resturant") {
        query.listen(
          (currentQuery) {
            if (currentQuery.isNotEmpty) {
              List<Vendor> queryVendors = [];
              _repo.getVendors("all").listen((vendors) {
                vendors.forEach((vendor) {
                  if (vendor.name
                      .toLowerCase()
                      .contains(currentQuery.toLowerCase())) {
                    queryVendors.add(vendor);
                  }
                });
              });
              changeQueryVendors(queryVendors);
            } else {
              changeQueryVendors([]);
            }
          },
        );
      }
    });
  }

  getVendors(String name) {
    _repo.getVendors(name).listen((vendors) {});
  }

  dispose() {
    _searchFilterSubject.close();
    _querySubject.close();
  }
}

SearchBloc searchBloc = SearchBloc();
