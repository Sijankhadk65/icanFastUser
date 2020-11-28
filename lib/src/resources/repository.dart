import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastuserapp/src/models/carousel_item.dart';
import 'package:fastuserapp/src/models/liquor.dart';
import 'package:fastuserapp/src/models/offers_item.dart';
import 'package:fastuserapp/src/models/promo_code.dart';
import 'package:fastuserapp/src/models/user.dart';
import 'package:fastuserapp/src/resources/cloud_storage_provider.dart';
import 'package:fastuserapp/src/resources/hive_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import '../models/order_ref.dart';
import '../models/rating.dart';
import '../models/vendor.dart';
import '../resources/firebase_auth_provider.dart';

import '../models/item.dart';
import '../models/online_order.dart';
import './firestore_provider.dart';

import 'dart:async';

class Repository {
  final _authProvider = FirebaseAuthProvider();
  final _firestoreProvider = FirestoreProvider();
  final _cloudStorageProvider = CloudStorageProvider();
  final _hiveProvider = HiveProvider();

  // For DB Usage

  Future<Box> openDB() => _hiveProvider.openBox();

  closeDB() => _hiveProvider.closeBox();

  // For DB Usage

  Stream<User> get onAuthStateChanged => _authProvider.onAuthStateChanged
      .map((user) => user != null ? user : null);

  Stream<MenuItem> getMenuItem(String createdAt) =>
      _firestoreProvider.getMenuItem(createdAt).transform(
        StreamTransformer.fromHandlers(
          handleData: (DocumentSnapshot snapshot, sink) {
            sink.add(
              parseToMenuItemModel(
                snapshot.data(),
              ),
            );
          },
        ),
      );

  Stream<Vendor> getVendor(String name) =>
      _firestoreProvider.getVendor(name).transform(
        StreamTransformer.fromHandlers(
          handleData: (DocumentSnapshot snapshot, sink) {
            sink.add(
              parseJsonToVendor(
                snapshot.data(),
              ),
            );
          },
        ),
      );

  Stream<int> vendorMinOrder(String name) =>
      _firestoreProvider.getVendor(name).transform(
        StreamTransformer.fromHandlers(
          handleData: (DocumentSnapshot snapshot, sink) {
            sink.add(
              snapshot.data()['minOrder'],
            );
          },
        ),
      );

  Stream<Map<String, dynamic>> getVendorLocation(String vendorName) =>
      _firestoreProvider.getVendor(vendorName).transform(
        StreamTransformer.fromHandlers(
          handleData: (DocumentSnapshot snapshot, sink) {
            if (snapshot.exists) {
              sink.add(
                {
                  "lat": snapshot.data()['lat'],
                  "lang": snapshot.data()['lang'],
                },
              );
            } else {
              sink.addError("No Vendor found");
            }
          },
        ),
      );

  Stream<List<int>> getDistanceRates() =>
      _firestoreProvider.getDistanceRates().transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<int> rates = [];
            snapshot.docs.forEach(
              (element) {
                rates.add(
                  element.data()['rate'],
                );
              },
            );
            sink.add(rates);
          },
        ),
      );

  Stream<List<String>> getVendorCategories(String vendor) =>
      _firestoreProvider.getVendorCategory(vendor).transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<String> _categories = [];
            snapshot.docs.forEach(
              (document) {
                _categories.add(
                  document.data()['name'],
                );
              },
            );
            sink.add(_categories);
          },
        ),
      );

  Stream<List<OrderRef>> getOrderRefs(Map<String, dynamic> user) =>
      _firestoreProvider.getOrderRefs(user).transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<OrderRef> orders = [];
            snapshot.docs.forEach(
              (document) {
                orders.add(
                  parseJsonToOrderRef(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(orders);
          },
        ),
      );

  Stream<List<OrderRef>> getClosedOrderRefs(Map<String, dynamic> user) =>
      _firestoreProvider.getClosedOrderRefs(user).transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<OrderRef> orders = [];
            snapshot.docs.forEach(
              (document) {
                orders.add(
                  parseJsonToOrderRef(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(orders);
          },
        ),
      );
  Future<void> deleteOrderRefs(String refID) =>
      _firestoreProvider.deleteOrderRef(refID);

  Stream<List<OnlineOrder>> getOrders(String refID) =>
      _firestoreProvider.getOrders(refID).transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<OnlineOrder> orders = [];
            snapshot.docs.forEach(
              (document) {
                if (document.exists) {
                  orders.add(
                    parseJsonToOnlineOrder(
                      document.data(),
                    ),
                  );
                } else {
                  sink.addError("No Doc found");
                }
              },
            );
            sink.add(orders);
          },
        ),
      );

  // Stream<OnlineOrder> getOrderCart(String tableID) =>
  //     _firestoreProvider.getOrder(tableID).transform(
  //       StreamTransformer<QuerySnapshot, OnlineOrder>.fromHandlers(
  //         handleData: (QuerySnapshot snapshot, sink) {
  //           snapshot.documentChanges.forEach(
  //             (doc) {s
  //               sink.add(parseJsonToOnlineOrder(doc.document.data));
  //             },
  //           );
  //         },
  //       ),
  //     );

  Future<User> googleSignIn() => _authProvider.signInWithGoogle();
  Future<User> appleSignIn() => _authProvider.appleSignIn();
  Future<bool> isAppleSiginInAvailable() => _authProvider.appleSignInAvailable;
  Future<void> addUser(Map<String, dynamic> user) =>
      _firestoreProvider.addNewUser(user);
  Future<void> signOut() => _authProvider.signOut();

  Stream<List<MenuItem>> getVendorMenu(String category, String vendor) =>
      _firestoreProvider.getVendorMenu(category, vendor).transform(
        StreamTransformer<QuerySnapshot, List<MenuItem>>.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<MenuItem> items = [];
            snapshot.docs.forEach(
              (doc) {
                if (parseToMenuItemModel(
                  doc.data(),
                ).isAvailable) {
                  items.add(
                    parseToMenuItemModel(
                      doc.data(),
                    ),
                  );
                }
              },
            );
            sink.add(items);
          },
        ),
      );
  // Future<void> addNewItemToCart(String docID, Map<String, dynamic> newData) =>
  //     _firestoreProvider.updateCart(docID, newData);

  // Future<void> removeItemFromCart(String docID, Map<String, dynamic> newData) =>
  //     _firestoreProvider.updateCart(docID, newData);
  // Future<void> decreaseItemCount(String docID, Map<String, dynamic> newData) =>
  //     _firestoreProvider.updateCart(docID, newData);
  // Future<void> addNewCart(
  //         String timeStamp, Map<String, dynamic> cartInfo, String tableID) =>
  //     _firestoreProvider.addNewCart(timeStamp, cartInfo, tableID);

  Stream<List<Vendor>> getVendors(String tag) =>
      _firestoreProvider.getVendors(tag).transform(
        StreamTransformer<QuerySnapshot, List<Vendor>>.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<Vendor> _vendors = [];
            snapshot.docs.forEach(
              (document) {
                _vendors.add(
                  parseJsonToVendor(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(_vendors);
          },
        ),
      );

  Stream<Vendor> getFeaturedVendor() =>
      _firestoreProvider.getFeaturedVendor().transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<Vendor> featuredVendors = [];
            snapshot.docs.forEach(
              (document) {
                featuredVendors.add(
                  parseJsonToVendor(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(featuredVendors.first);
          },
        ),
      );

  Stream<List<MenuItem>> getVendorFeaturedMenu(String vendorName) =>
      _firestoreProvider.getVendorFeaturedMenu(vendorName).transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<MenuItem> featuredItems = [];
            snapshot.docs.forEach(
              (document) {
                featuredItems.add(
                  parseToMenuItemModel(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(featuredItems);
          },
        ),
      );

  Future<void> createRefrence(Map<String, dynamic> refObj) =>
      _firestoreProvider.createRefrence(refObj);
  Future<void> saveOrder(Map<String, dynamic> order) =>
      _firestoreProvider.saveOrder(order);

  Stream<List<String>> getTags() => _firestoreProvider.getTags().transform(
        StreamTransformer<QuerySnapshot, List<String>>.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<String> tags = [];
            snapshot.docs.forEach(
              (document) {
                tags.add(
                  document.data()['name'],
                );
              },
            );
            sink.add(tags);
          },
        ),
      );
  // Ratings
  Stream<List<Rating>> getRatings(String vendorName) =>
      _firestoreProvider.getRatings(vendorName).transform(
        StreamTransformer<QuerySnapshot, List<Rating>>.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<Rating> ratings = [];
            snapshot.docs.forEach(
              (document) {
                ratings.add(
                  parseJsonToRating(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(ratings);
          },
        ),
      );

  Future<void> saveRating(String vendorName, Map<String, dynamic> rating) =>
      _firestoreProvider.saveRating(vendorName, rating);

  Stream<List<CarouselItem>> getCarouselItems() =>
      _firestoreProvider.getCarouselItems().transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<CarouselItem> carouselItems = [];
            snapshot.docs.forEach(
              (document) {
                carouselItems.add(
                  parseToCarouselItem(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(carouselItems);
          },
        ),
      );

  Stream<List<OffersItem>> getSpecialOffers() =>
      _firestoreProvider.getOffers().transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<OffersItem> offers = [];
            snapshot.docs.forEach(
              (document) {
                offers.add(
                  parseToOffersItem(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(offers);
          },
        ),
      );

  Stream<List<Vendor>> getVegVendors() =>
      _firestoreProvider.getVegVendors().transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<Vendor> vendors = [];
            snapshot.docs.forEach(
              (document) {
                vendors.add(
                  parseJsonToVendor(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(vendors);
          },
        ),
      );
  Stream<List<Vendor>> getHalalVendors() =>
      _firestoreProvider.getHalalVendors().transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<Vendor> vendors = [];
            snapshot.docs.forEach(
              (document) {
                vendors.add(
                  parseJsonToVendor(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(vendors);
          },
        ),
      );

  Stream<List<MenuItem>> getVegFood() =>
      _firestoreProvider.getVegFood().transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<MenuItem> vendors = [];
            snapshot.docs.forEach(
              (document) {
                vendors.add(
                  parseToMenuItemModel(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(vendors);
          },
        ),
      );

  Stream<List<MenuItem>> getHalalFood() =>
      _firestoreProvider.getHalalFood().transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<MenuItem> vendors = [];
            snapshot.docs.forEach(
              (document) {
                vendors.add(
                  parseToMenuItemModel(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(vendors);
          },
        ),
      );

  Stream<bool> getUserStatus(String email) =>
      _firestoreProvider.getUser(email).transform(
        StreamTransformer.fromHandlers(
          handleData: (DocumentSnapshot snapshot, sink) {
            if (snapshot.exists) {
              sink.add(true);
            } else {
              sink.add(false);
            }
          },
        ),
      );
  Stream<FastUser> getUser(String email) =>
      _firestoreProvider.getUser(email).transform(
        StreamTransformer.fromHandlers(
          handleData: (DocumentSnapshot snapshot, sink) {
            sink.add(
              parseJsonToUser(
                snapshot.data(),
              ),
            );
          },
        ),
      );
  Stream<PromoCode> getPromoCode(String code) =>
      _firestoreProvider.getPromoCode(code).transform(
        StreamTransformer.fromHandlers(
          handleData: (DocumentSnapshot snapshot, sink) {
            if (snapshot.exists) {
              sink.add(
                parseJsonToPromoCode(
                  snapshot.data(),
                ),
              );
            }
          },
        ),
      );
  Stream<List<String>> getFavourites(String type, String email) =>
      _firestoreProvider.getFavourites(type, email).transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<String> favourites = [];
            snapshot.docs.forEach(
              (document) {
                favourites.add(
                  document.data()['name'],
                );
              },
            );
            sink.add(favourites);
          },
        ),
      );

  Stream<List<String>> getFavouritesFood(String email) =>
      _firestoreProvider.getFavouritesFood(email).transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<String> favourites = [];
            snapshot.docs.forEach(
              (document) {
                favourites.add(
                  document.data()['createdAt'],
                );
              },
            );
            sink.add(favourites);
          },
        ),
      );

  Stream<List<Liquor>> getLiquor(String category) =>
      _firestoreProvider.getLiquor(category).transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<Liquor> liquors = [];
            snapshot.docs.forEach(
              (document) {
                liquors.add(
                  parseToLiquorModel(
                    document.data(),
                  ),
                );
              },
            );
            sink.add(liquors);
          },
        ),
      );

  Future<void> addPromoCode(String email, String code, List<String> codes) =>
      _firestoreProvider.addPromoCode(email, code, codes);
  Future<void> saveUserToken(String email, Map<String, dynamic> tokenData) =>
      _firestoreProvider.saveUserToken(email, tokenData);
  Future<void> updateUserHomeLocation(
          {Map<String, dynamic> home, String email}) =>
      _firestoreProvider.updateUserHomeLocation(home: home, email: email);
  Future<void> updateUserOfficeLocation(
          {Map<String, dynamic> office, String email}) =>
      _firestoreProvider.updateUserOfficeLocation(office: office, email: email);
  updateProfilePicture(String email, String file) =>
      _firestoreProvider.updateProfilePicture(email, file);
  Future<void> addToFavourites(
          String type, String email, Map<String, dynamic> itemData) =>
      _firestoreProvider.addToFavourite(type, email, itemData);
  Future<void> removeFavourites(
          String type, String email, Map<String, dynamic> itemName) =>
      _firestoreProvider.removeFavourites(type, email, itemName);
  // Profile Photo Upload
  Future<StorageTaskSnapshot> savePhoto(File imageFile, String filename) =>
      _cloudStorageProvider.uploadProfileImageToServer(imageFile, filename);
}
