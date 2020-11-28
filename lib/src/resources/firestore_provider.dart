import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  final _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getOrder(String tableID) {
    return _firestore
        .collection("orders")
        .where("table", isEqualTo: tableID)
        .snapshots();
  }

  Future<void> createRefrence(Map<String, dynamic> refObj) {
    return _firestore.doc("liveOnlineOrders/${refObj['refID']}").set(refObj);
  }

  Future<void> saveOrder(Map<String, dynamic> order) {
    return _firestore
        .doc("liveOnlineOrders/${order['refID']}")
        .collection("orders")
        .doc(order['createdAt'])
        .set(order);
  }

  Stream<DocumentSnapshot> getVendor(String vendorName) {
    return _firestore.doc("v3-vendors/$vendorName").snapshots();
  }

  Stream<DocumentSnapshot> getMenuItem(String createdAt) =>
      _firestore.collection("v3-menu").doc(createdAt).snapshots();

  Stream<QuerySnapshot> getVendorMenu(String category, String vendor) {
    if (category == "all") return _firestore.collection("v3-menu").snapshots();
    return _firestore
        .collection("v3-menu")
        .where("category", isEqualTo: category)
        .where("vendor", isEqualTo: vendor)
        .snapshots();
  }

  Stream<QuerySnapshot> getVendorFeaturedMenu(String vendorName) => _firestore
      .collection("v3-menu")
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
      _firestore.doc("liveOnlineOrders/$refID").delete();

  Stream<QuerySnapshot> getOrders(String refID) {
    return _firestore
        .doc("liveOnlineOrders/$refID")
        .collection("orders")
        .snapshots();
  }

  addNewCart(String timeStamp, Map<String, dynamic> cartInfo, String tableID) {
    _firestore
        .collection("tables")
        .doc(tableID)
        .update({"status": "active"}).whenComplete(() {});

    return _firestore
        .collection("liveOnlineOrders")
        .doc(timeStamp)
        .set(cartInfo);
  }

  Stream<QuerySnapshot> getVendorsFromName(String name) {
    return _firestore
        .collection("v3-vendors")
        .where("name", isEqualTo: name)
        .snapshots();
  }

  Stream<QuerySnapshot> getDistanceRates() =>
      _firestore.collection("distanceRates").snapshots();

  Stream<QuerySnapshot> getVendors(String tag) {
    // if (tag == "all") return _firestore.collection("vendors").snapshots();
    return _firestore
        .collection("v3-vendors")
        .where("tags", arrayContains: tag)
        .snapshots();
  }

  Stream<QuerySnapshot> getFeaturedVendor() => _firestore
      .collection("v3-vendors")
      .where("isFeatured", isEqualTo: true)
      .snapshots();

  Future<void> updateCart(String docID, Map<String, dynamic> newData) {
    return _firestore.collection("liveOnlineOrders").doc(docID).update(newData);
  }

  Future<void> addPromoCode(String email, String code, List<String> codes) =>
      _firestore.collection("users").doc(email).update(
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
      _firestore.collection("users").doc(data['email']).set(data);

  Stream<QuerySnapshot> getTags() => _firestore.collection("tags").snapshots();

  // ratings
  Stream<QuerySnapshot> getRatings(String vendorName) => _firestore
      .doc("v3-vendors/$vendorName")
      .collection("ratings")
      .limit(20)
      .snapshots();
  Future<void> saveRating(String vendorName, Map<String, dynamic> rating) =>
      _firestore
          .doc("v3-vendors/$vendorName/ratings/${rating['createdAt']}")
          .set(rating);
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
      _firestore.doc("users/$email").snapshots();
  Future<void> saveUserToken(
    String email,
    Map<String, dynamic> tokenData,
  ) =>
      _firestore
          .doc("users/$email")
          .collection("tokens")
          .doc(tokenData['token'])
          .set(tokenData);
  updateProfilePicture(String email, String file) =>
      _firestore.doc("users/$email").update(
        {
          "photoURI": file,
        },
      );

  Future<void> updateUserHomeLocation(
          {Map<String, dynamic> home, String email}) =>
      _firestore.doc("users/$email").update(
        {
          "home": home,
        },
      );
  Future<void> updateUserOfficeLocation(
          {Map<String, dynamic> office, String email}) =>
      _firestore.doc("users/$email").update(
        {
          "office": office,
        },
      );

  Stream<DocumentSnapshot> getPromoCode(String code) =>
      _firestore.doc("promoCodes/$code").snapshots();

  Stream<QuerySnapshot> getFavourites(String type, String email) {
    if (type == "resturant")
      return _firestore
          .doc("users/$email")
          .collection("favourite resturants")
          .snapshots();

    if (type == "food")
      return _firestore
          .doc("users/$email")
          .collection("favourite foods")
          .snapshots();
  }

  Stream<QuerySnapshot> getFavouritesFood(String email) =>
      _firestore.doc("users/$email").collection("favourite foods").snapshots();

  Stream<QuerySnapshot> getVegFood() {
    return _firestore
        .collection("v3-menu")
        .where("isVeg", isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getVegVendors() {
    return _firestore
        .collection("v3-vendors")
        .where("isVeg", isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getHalalFood() {
    return _firestore
        .collection("v3-menu")
        .where("isHalal", isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getHalalVendors() {
    return _firestore
        .collection("v3-vendors")
        .where("isHalal", isEqualTo: true)
        .snapshots();
  }

  Future<void> addToFavourite(
      String type, String email, Map<String, dynamic> itemData) {
    if (type == "resturant")
      return _firestore
          .doc("users/$email")
          .collection("favourite resturants")
          .doc(itemData['name'])
          .set(itemData);
    if (type == "food")
      return _firestore
          .doc("users/$email")
          .collection("favourite foods")
          .doc(itemData['createdAt'])
          .set(itemData);
  }

  Future<void> removeFavourites(
      String type, String email, Map<String, dynamic> itemData) {
    if (type == "resturant")
      return _firestore
          .doc("users/$email")
          .collection("favourite resturants")
          .doc(itemData['name'])
          .delete();
    if (type == "food")
      return _firestore
          .doc("users/$email")
          .collection("favourite foods")
          .doc(itemData['createdAt'])
          .delete();
  }

  Stream<QuerySnapshot> getLiquor(String category) => _firestore
      .collection("liquor")
      .where("type", isEqualTo: category)
      .snapshots();
}
