import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastuserapp/src/models/carousel_item.dart';
import 'package:fastuserapp/src/models/offers_item.dart';
import 'package:fastuserapp/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Stream<FirebaseUser> get onAuthStateChanged =>
      _authProvider.onAuthStateChanged
          .map((user) => user != null ? user : null);

  Stream<Map<String, dynamic>> getVendorLocation(String vendorName) =>
      _firestoreProvider.getVendor(vendorName).transform(
          StreamTransformer.fromHandlers(
              handleData: (DocumentSnapshot snapshot, sink) {
        if (snapshot.exists) {
          sink.add(
            {
              "lat": snapshot.data['lat'],
              "lang": snapshot.data['lang'],
            },
          );
        } else {
          sink.addError("No Vendor found");
        }
      }));

  Stream<List<String>> getVendorCategories(String vendor) =>
      _firestoreProvider.getVendorCategory(vendor).transform(
        StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<String> _categories = [];
            snapshot.documents.forEach(
              (document) {
                _categories.add(document.data['name']);
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
            snapshot.documents.forEach(
              (document) {
                orders.add(parseJsonToOrderRef(document.data));
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
            snapshot.documents.forEach(
              (document) {
                orders.add(parseJsonToOrderRef(document.data));
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
            snapshot.documents.forEach(
              (document) {
                if (document.exists) {
                  orders.add(parseJsonToOnlineOrder(document.data));
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
  //             (doc) {
  //               sink.add(parseJsonToOnlineOrder(doc.document.data));
  //             },
  //           );
  //         },
  //       ),
  //     );

  Future<FirebaseUser> googleSignIn() => _authProvider.signInWithGoogle();
  Future<void> addUser(Map<String, dynamic> user) =>
      _firestoreProvider.addNewUser(user);
  Future<void> signOut() => _authProvider.signOut();

  Stream<List<MenuItem>> getVendorMenu(String category, String vendor) =>
      _firestoreProvider.getVendorMenu(category, vendor).transform(
        StreamTransformer<QuerySnapshot, List<MenuItem>>.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<MenuItem> items = [];
            snapshot.documents.forEach(
              (doc) {
                if (parseToMenuItemModel(doc.data).isAvailable) {
                  items.add(parseToMenuItemModel(doc.data));
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
            snapshot.documents.forEach(
              (document) {
                _vendors.add(parseJsonToVendor(document.data));
              },
            );
            sink.add(_vendors);
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
        snapshot.documents.forEach((document) {
          tags.add(document.data['name']);
        });
        sink.add(tags);
      }));
  // Ratings
  Stream<List<Rating>> getRatings(String vendorName) =>
      _firestoreProvider.getRatings(vendorName).transform(
        StreamTransformer<QuerySnapshot, List<Rating>>.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
            List<Rating> ratings = [];
            snapshot.documents.forEach(
              (document) {
                ratings.add(
                  parseJsonToRating(document.data),
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
            snapshot.documents.forEach(
              (document) {
                carouselItems.add(
                  parseToCarouselItem(
                    document.data,
                  ),
                );
              },
            );
            sink.add(carouselItems);
          },
        ),
      );

  Stream<List<OffersItem>> getSpecialOffers() =>
      _firestoreProvider.getOffers().transform(StreamTransformer.fromHandlers(
          handleData: (QuerySnapshot snapshot, sink) {
        List<OffersItem> offers = [];
        snapshot.documents.forEach((document) {
          offers.add(parseToOffersItem(document.data));
        });
        sink.add(offers);
      }));

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
  Stream<User> getUser(String email) =>
      _firestoreProvider.getUser(email).transform(
        StreamTransformer.fromHandlers(
          handleData: (DocumentSnapshot snapshot, sink) {
            sink.add(parseJsonToUser(snapshot.data));
          },
        ),
      );
  Future<void> saveUserToken(String email, Map<String, dynamic> tokenData) =>
      _firestoreProvider.saveUserToken(email, tokenData);
}
