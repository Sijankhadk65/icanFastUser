import 'package:fastuserapp/src/models/offers_item.dart';

import '../models/vendor.dart';
import '../models/item.dart';
import '../resources/repository.dart';

import 'package:rxdart/rxdart.dart';

class CartMenuBloc {
  List<MenuItem> _cartMenu = [];
  final _repository = Repository();
  List<Vendor> taggedVenors = [];

  final BehaviorSubject<List<Vendor>> _vendorsSubject =
      BehaviorSubject<List<Vendor>>();
  Stream<List<Vendor>> get vendors => _vendorsSubject.stream;
  Function(List<Vendor>) get changeVendors => _vendorsSubject.sink.add;

  final _cartMenuSubject = BehaviorSubject<List<MenuItem>>();
  Function(List<MenuItem>) get changeCartMenu => _cartMenuSubject.sink.add;
  Stream<List<MenuItem>> get cartMenu => _cartMenuSubject.stream;

  final BehaviorSubject<List<String>> _categoriesSubject =
      BehaviorSubject<List<String>>();
  Stream<List<String>> get categories => _categoriesSubject.stream;
  Function(List<String>) get changeCategories => _categoriesSubject.sink.add;

  // For the search
  final BehaviorSubject<String> _querySubject = BehaviorSubject<String>();
  Stream<String> get query => _querySubject.stream;
  Function(String) get changeQuery => _querySubject.sink.add;

  final BehaviorSubject<List<Vendor>> _queryItemsSubject =
      BehaviorSubject<List<Vendor>>();
  Stream<List<Vendor>> get queryItems => _queryItemsSubject.stream;
  Function(List<Vendor>) get changeQueryItems => _queryItemsSubject.sink.add;

  final BehaviorSubject<List<String>> _tagsSubject =
      BehaviorSubject<List<String>>();
  Stream<List<String>> get tags => _tagsSubject.stream;
  Function(List<String>) get changeTags => _tagsSubject.sink.add;

  CartMenuBloc() {
    query.listen((event) {
      if (event.isNotEmpty) {
        List<Vendor> taggedVendors = [];
        _repository.getVendors("all").listen(
          (vendors) {
            changeVendors(vendors);
            vendors.forEach((vendor) {
              vendor.tags.forEach((tag) {
                if (taggedVenors.isNotEmpty) {
                  if (tag.toLowerCase().contains(event.toLowerCase()) &&
                      !taggedVenors.contains(vendor)) {
                    taggedVendors.add(vendor);
                  }
                } else {
                  if (tag.toLowerCase().contains(event.toLowerCase())) {
                    taggedVendors.add(vendor);
                  }
                }
              });
            });
            changeQueryItems(taggedVendors);
          },
        );
      }
    });
  }

  getVendors(String tag) {
    _repository.getVendors(tag).listen(
      (vendors) {
        changeVendors(vendors);
      },
    );
  }

  Stream<List<MenuItem>> getMenu(String category, String vendor) {
    return _repository.getVendorMenu(category, vendor);
  }

  getCategories(String vendor) {
    _repository.getVendorCategories(vendor).listen(
      (categories) {
        changeCategories(categories);
      },
    );
  }

  getTags() {
    _repository.getTags().listen(
      (tags) {
        changeTags(tags);
      },
    );
  }

  Stream<List<OffersItem>> getOffers() => _repository.getSpecialOffers();

  void dispose() {
    _cartMenuSubject.close();
    _categoriesSubject.close();
    _vendorsSubject.close();
    _cartMenu.clear();
    _tagsSubject.close();
    _queryItemsSubject.close();
  }
}
