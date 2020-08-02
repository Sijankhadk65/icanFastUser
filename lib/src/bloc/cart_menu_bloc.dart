import 'package:fastuserapp/src/models/offers_item.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

import '../models/vendor.dart';
import '../models/item.dart';
import '../resources/repository.dart';

import 'package:rxdart/rxdart.dart';

class CartMenuBloc {
  List<MenuItem> _cartMenu = [];
  final _repository = Repository();
  List<Vendor> taggedVenors = [];
  Distance _distance = Distance();

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

  final BehaviorSubject<List<Vendor>> _quickAccessVendorListSubject =
      BehaviorSubject<List<Vendor>>();
  Stream<List<Vendor>> get quickAccessVendorList =>
      _quickAccessVendorListSubject.stream;
  Function(List<Vendor>) get changeQucikAccessVendorList =>
      _quickAccessVendorListSubject.sink.add;

  final BehaviorSubject<List<MenuItem>> _quickAccessMenuListSubject =
      BehaviorSubject<List<MenuItem>>();
  Stream<List<MenuItem>> get quickAccessMenuList =>
      _quickAccessMenuListSubject.stream;
  Function(List<MenuItem>) get changeQuickAccessMenuList =>
      _quickAccessMenuListSubject.sink.add;

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

  Stream<MenuItem> getMenuItem(String createdAt) =>
      _repository.getMenuItem(createdAt);

  Stream<int> getVendorMinOrder(String name) =>
      _repository.vendorMinOrder(name);

  getVendors(String tag) {
    if (tag == "nearby") {
      _repository.getVendors("all").listen(
        (vendors) async {
          Location _location = Location();
          LocationData _userLocation = await _location.getLocation();
          vendors = vendors
              .where(
                (vendor) =>
                    _distance.as(
                      LengthUnit.Meter,
                      LatLng(
                        _userLocation.latitude,
                        _userLocation.longitude,
                      ),
                      LatLng(
                        vendor.lat,
                        vendor.lang,
                      ),
                    ) <=
                    3000,
              )
              .toList();
          changeVendors(vendors);
        },
      );
    } else {
      _repository.getVendors(tag).listen(
        (vendors) {
          changeVendors(vendors);
        },
      );
    }
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
        tags = ["nearby", ...tags];
        changeTags(tags);
      },
    );
  }

  Stream<List<OffersItem>> getOffers() => _repository.getSpecialOffers();

  Future<void> toogleFavourite(
    bool isFeatured,
    String type,
    String email,
    Map<String, dynamic> itemData,
  ) {
    if (isFeatured) {
      return removeFavourites(type, email, itemData);
    } else {
      return addToFavourite(type, email, itemData);
    }
  }

  Future<void> addToFavourite(
          String type, String email, Map<String, dynamic> itemData) =>
      _repository.addToFavourites(type, email, itemData);

  Future<void> removeFavourites(
          String type, String email, Map<String, dynamic> itemName) =>
      _repository.removeFavourites(type, email, itemName);

  Stream<List<String>> getFavourites(String type, String email) =>
      _repository.getFavourites(type, email);
  Stream<List<String>> getFavouritesFood(String email) =>
      _repository.getFavouritesFood(email);

  Stream<Vendor> getVendor(String name) => _repository.getVendor(name);

  getQuickAccessList(String type) {
    if (type == "veg") {
      _repository.getVegVendors().listen((vendors) {
        changeQucikAccessVendorList(vendors);
      });
      _repository.getVegFood().listen((menu) {
        changeQuickAccessMenuList(menu);
      });
    } else if (type == "halal") {
      _repository.getHalalVendors().listen((vendors) {
        changeQucikAccessVendorList(vendors);
      });
      _repository.getHalalFood().listen((menu) {
        changeQuickAccessMenuList(menu);
      });
    }
  }

  void dispose() {
    _cartMenuSubject.close();
    _categoriesSubject.close();
    _vendorsSubject.close();
    _cartMenu.clear();
    _tagsSubject.close();
    _queryItemsSubject.close();
  }
}
