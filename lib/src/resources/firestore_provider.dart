import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  final _firestore = Firestore.instance;
  Stream<QuerySnapshot> getOrder(String tableID) {
    return _firestore
        .collection("orders")
        .where("table", isEqualTo: tableID)
        .snapshots();
  }

  Future<void> createRefrence(Map<String, dynamic> refObj) {
    return _firestore
        .document("liveOnlineOrders/${refObj['refID']}")
        .setData(refObj);
  }

  Future<void> saveOrder(Map<String, dynamic> order) {
    return _firestore
        .document("liveOnlineOrders/${order['refID']}")
        .collection("orders")
        .document(order['createdAt'])
        .setData(order);
  }

  Stream<DocumentSnapshot> getVendor(String vendorName) {
    return _firestore.document("vendors/$vendorName").snapshots();
  }

  Stream<DocumentSnapshot> getMenuItem(String createdAt) =>
      _firestore.collection("menu").document(createdAt).snapshots();

  Stream<QuerySnapshot> getVendorMenu(String category, String vendor) {
    if (category == "all") return _firestore.collection("menu").snapshots();
    return _firestore
        .collection("menu")
        .where("category", isEqualTo: category)
        .where("vendor", isEqualTo: vendor)
        .snapshots();
  }

  Stream<QuerySnapshot> getVendorFeaturedMenu(String vendorName) => _firestore
      .collection("menu")
      .where("vendor", isEqualTo: vendorName)
      .where("isFeatured", isEqualTo: true)
      .snapshots();

  Stream<QuerySnapshot> getVendorCategory(String vendor) {
    return _firestore
        .collection("category")
        .where("vendors", arrayContains: vendor)
        .snapshots();
  }

  Stream<QuerySnapshot> getOrderRefs(Map<String, dynamic> user) {
    return _firestore
        .collection("liveOnlineOrders")
        .where(
          "user.email",
          isEqualTo: user['email'],
        )
        .where(
          "isPaid",
          isEqualTo: false,
        )
        .snapshots();
  }

  Stream<QuerySnapshot> getClosedOrderRefs(Map<String, dynamic> user) {
    return _firestore
        .collection("liveOnlineOrders")
        .where(
          "user.email",
          isEqualTo: user['email'],
        )
        .where(
          "isPaid",
          isEqualTo: true,
        )
        .snapshots();
  }

  Future<void> deleteOrderRef(String refID) =>
      _firestore.document("liveOnlineOrders/$refID").delete();

  Stream<QuerySnapshot> getOrders(String refID) {
    return _firestore
        .document("liveOnlineOrders/$refID")
        .collection("orders")
        .snapshots();
  }

  addNewCart(String timeStamp, Map<String, dynamic> cartInfo, String tableID) {
    _firestore
        .collection("tables")
        .document(tableID)
        .updateData({"status": "active"}).whenComplete(() {});

    return _firestore
        .collection("liveOnlineOrders")
        .document(timeStamp)
        .setData(cartInfo);
  }

  Stream<QuerySnapshot> getVendorsFromName(String name) {
    return _firestore
        .collection("vendors")
        .where("name", isEqualTo: name)
        .snapshots();
  }

  Stream<QuerySnapshot> getDistanceRates() =>
      _firestore.collection("distanceRates").snapshots();

  Stream<QuerySnapshot> getVendors(String tag) {
    // if (tag == "all") return _firestore.collection("vendors").snapshots();
    return _firestore
        .collection("vendors")
        .where("tags", arrayContains: tag)
        .snapshots();
  }

  Stream<QuerySnapshot> getFeaturedVendor() => _firestore
      .collection("vendors")
      .where("isFeatured", isEqualTo: true)
      .snapshots();

  Future<void> updateCart(String docID, Map<String, dynamic> newData) {
    return _firestore
        .collection("liveOnlineOrders")
        .document(docID)
        .updateData(newData);
  }

  Future<void> addPromoCode(String email, String code, List<String> codes) =>
      _firestore.collection("users").document(email).updateData(
        {
          'promoCodes': [
            ...codes,
            code,
          ],
        },
      );

  // Stream<DocumentSnapshot> checkForUser(String email) =>
  //     _firestore.document("users/$email").snapshots();

  Future<void> addNewUser(Map<String, dynamic> data) =>
      _firestore.collection("users").document(data['email']).setData(data);

  Stream<QuerySnapshot> getTags() => _firestore.collection("tags").snapshots();

  // ratings
  Stream<QuerySnapshot> getRatings(String vendorName) => _firestore
      .document("vendors/$vendorName")
      .collection("ratings")
      .limit(20)
      .snapshots();
  Future<void> saveRating(String vendorName, Map<String, dynamic> rating) =>
      _firestore
          .document("vendors/$vendorName/ratings/${rating['createdAt']}")
          .setData(rating);
  Stream<QuerySnapshot> getCarouselItems() {
    return _firestore
        .collection("carousel")
        .where("isActive", isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getOffers() {
    return _firestore
        .collection("specialOffers")
        .where("isAvailable", isEqualTo: true)
        .snapshots();
  }

  Stream<DocumentSnapshot> getUser(String email) =>
      _firestore.document("users/$email").snapshots();
  Future<void> saveUserToken(String email, Map<String, dynamic> tokenData) =>
      _firestore
          .document("users/$email")
          .collection("tokens")
          .document(tokenData['token'])
          .setData(tokenData);

  Future<void> updateUserHomeLocation(
          {Map<String, dynamic> home, String email}) =>
      _firestore.document("users/$email").updateData({
        "home": home,
      });
  Future<void> updateUserOfficeLocation(
          {Map<String, dynamic> office, String email}) =>
      _firestore.document("users/$email").updateData({
        "office": office,
      });

  Stream<DocumentSnapshot> getPromoCode(String code) =>
      _firestore.document("promoCodes/$code").snapshots();

  Stream<QuerySnapshot> getFavourites(String type, String email) {
    if (type == "resturant")
      return _firestore
          .document("users/$email")
          .collection("favourite resturants")
          .snapshots();

    if (type == "food")
      return _firestore
          .document("users/$email")
          .collection("favourite foods")
          .snapshots();
  }

  Stream<QuerySnapshot> getFavouritesFood(String email) => _firestore
      .document("users/$email")
      .collection("favourite foods")
      .snapshots();

  Stream<QuerySnapshot> getVegFood() {
    return _firestore
        .collection("menu")
        .where("isVeg", isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getVegVendors() {
    return _firestore
        .collection("vendors")
        .where("isVeg", isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getHalalFood() {
    return _firestore
        .collection("menu")
        .where("isHalal", isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getHalalVendors() {
    return _firestore
        .collection("vendors")
        .where("isHalal", isEqualTo: true)
        .snapshots();
  }

  Future<void> addToFavourite(
      String type, String email, Map<String, dynamic> itemData) {
    if (type == "resturant")
      return _firestore
          .document("users/$email")
          .collection("favourite resturants")
          .document(itemData['name'])
          .setData(itemData);
    if (type == "food")
      return _firestore
          .document("users/$email")
          .collection("favourite foods")
          .document(itemData['createdAt'])
          .setData(itemData);
  }

  Future<void> removeFavourites(
      String type, String email, Map<String, dynamic> itemData) {
    if (type == "resturant")
      return _firestore
          .document("users/$email")
          .collection("favourite resturants")
          .document(itemData['name'])
          .delete();
    if (type == "food")
      return _firestore
          .document("users/$email")
          .collection("favourite foods")
          .document(itemData['createdAt'])
          .delete();
  }

  Stream<QuerySnapshot> getLiquor(String category) => _firestore
      .collection("liquor")
      .where("type", isEqualTo: category)
      .snapshots();
}
