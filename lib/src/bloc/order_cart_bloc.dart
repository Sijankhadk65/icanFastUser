import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

import '../models/order_ref.dart';
import '../models/cart_items.dart';
import '../models/item.dart';
import '../models/online_order.dart';
import '../resources/repository.dart';

import 'package:rxdart/rxdart.dart';

class OrderCartBloc {
  List<Map<String, dynamic>> _localOrders = [];
  int _totalPrice = 0;
  int _totalLength = 0;
  int _cartsTotal = 0;
  String _refID = "";
  String _physicaLocation = "";

  final _repository = Repository();

  final BehaviorSubject<List<OrderRef>> _orderRefrenceSubject =
      BehaviorSubject<List<OrderRef>>();
  Stream<List<OrderRef>> get orderRefrence => _orderRefrenceSubject.stream;
  Function(List<OrderRef>) get changeOrderRefrence =>
      _orderRefrenceSubject.sink.add;

  final BehaviorSubject<List<OnlineOrder>> _liveOrdersSubject =
      BehaviorSubject<List<OnlineOrder>>();
  Stream<List<OnlineOrder>> get liveOrders => _liveOrdersSubject.stream;
  Function(List<OnlineOrder>) get changeLiveOrders =>
      _liveOrdersSubject.sink.add;

  final BehaviorSubject<List<OnlineOrder>> _localOrderSubject =
      BehaviorSubject<List<OnlineOrder>>();
  Stream<List<OnlineOrder>> get localOrder => _localOrderSubject.stream;
  Function(List<OnlineOrder>) get changeLocalOrders =>
      _localOrderSubject.sink.add;

  final BehaviorSubject<OnlineOrder> _currentOrderSubject =
      BehaviorSubject<OnlineOrder>();
  Stream<OnlineOrder> get currentOrder => _currentOrderSubject.stream;
  Function(OnlineOrder) get changeCurrentOrder => _currentOrderSubject.sink.add;

  final BehaviorSubject<List<CartItem>> _cartItemsSubject =
      BehaviorSubject<List<CartItem>>();
  Stream<List<CartItem>> get cartItems => _cartItemsSubject.stream;
  Function(List<CartItem>) get changeCartItems => _cartItemsSubject.sink.add;

  final BehaviorSubject<int> _totalPriceSubject = BehaviorSubject<int>();
  Stream<int> get totalPrice => _totalPriceSubject.stream;
  Function(int) get changeTotalPrice => _totalPriceSubject.sink.add;

  final BehaviorSubject<int> _totalLengthSubject = BehaviorSubject<int>();
  Stream<int> get totalLength => _totalLengthSubject.stream;
  Function(int) get changeTotalLenght => _totalLengthSubject.sink.add;

  final BehaviorSubject<int> _cartsTotalSubject = BehaviorSubject<int>();
  Stream<int> get cartsTotal => _cartsTotalSubject.stream;
  Function(int) get changeCartsTotal => _cartsTotalSubject.sink.add;

  final BehaviorSubject<LocationData> _currentLocationSubject =
      BehaviorSubject<LocationData>();
  Stream<LocationData> get currentLocation => _currentLocationSubject.stream;
  Function(LocationData) get changeCurrentLocation =>
      _currentLocationSubject.sink.add;
  final BehaviorSubject<Address> _physicalLocationSubject =
      BehaviorSubject<Address>();
  Stream<Address> get physicalLocation => _physicalLocationSubject.stream;
  Function(Address) get changePhysicalLocation =>
      _physicalLocationSubject.sink.add;

  final BehaviorSubject<bool> _isSavingSubject = BehaviorSubject<bool>();
  Stream<bool> get isSaving => _isSavingSubject.stream;
  Function(bool) get changeSavingStatus => _isSavingSubject.sink.add;

  final BehaviorSubject<double> _deliveryChargeSubject =
      BehaviorSubject<double>();
  Stream<double> get deliveryCharge => _deliveryChargeSubject.stream;
  Function(double) get changeDeliveryCharge => _deliveryChargeSubject.sink.add;

  final BehaviorSubject<bool> _checkedOutSubject = BehaviorSubject<bool>();
  Stream<bool> get checkedOut => _checkedOutSubject.stream;
  Function(bool) get changeCheckoutStatus => _checkedOutSubject.sink.add;

  OrderCartBloc() {
    changeTotalLenght(0);
    changeTotalPrice(0);
    changeSavingStatus(false);
    changeCheckoutStatus(false);
    getCurrentLocation();
  }

  getOrderRefs(Map<String, dynamic> user) {
    _repository.getOrderRefs(user).listen(
      (orderRefs) {
        changeOrderRefrence(orderRefs);
      },
    );
  }

  getLiveOrders(String refID) {
    _repository.getLiveOrders(refID).listen((orders) {
      changeLiveOrders(orders);
    });
  }

  void addNewOrder(String vendor, MenuItem newItem, Map<String, dynamic> user) {
    if (!_localOrders
        .map((e) => e['vendor'].toLowerCase())
        .toList()
        .contains(vendor.toLowerCase())) {
      _localOrders.add(
        {
          "vendor": vendor,
          "items": [],
          "totalPrice": 0,
          "createdAt": DateTime.now().toIso8601String(),
          "status": [],
          "cartLength": 0,
        },
      );
      addItemsToCart(vendor, newItem);
      changeLocalOrders(
          _localOrders.map((order) => parseJsonToOnlineOrder(order)).toList());
    } else {
      addItemsToCart(vendor, newItem);
      changeLocalOrders(
          _localOrders.map((order) => parseJsonToOnlineOrder(order)).toList());
    }
  }

  void addItemsToCart(String vendor, MenuItem newItem) {
    _localOrders.forEach(
      (localOrder) {
        if (localOrder['vendor'] == vendor) {
          if (localOrder['items'].isEmpty) {
            localOrder['items'].add(
              newFromItemModel(newItem).toJson(),
            );
            changeCartItems(
              localOrder['items']
                  .map<CartItem>(
                    (item) => parseToCartItem(item),
                  )
                  .toList(),
            );
            localOrder['totalPrice'] += newItem.price;
            localOrder['cartLength'] += 1;
          } else if (localOrder['items']
              .map(
                (item) => item['name'],
              )
              .toList()
              .contains(newItem.name)) {
            localOrder['items'].forEach((item) {
              if (item['name'] == newItem.name) {
                item['quantity'] += 1;
                localOrder['totalPrice'] -= item['totalPrice'];
                item['totalPrice'] = item['quantity'] * item['price'];
                localOrder['totalPrice'] += item['totalPrice'];
                localOrder['cartLength'] += 1;
              }
            });
          } else {
            localOrder['items'].add(
              newFromItemModel(newItem).toJson(),
            );
            changeCartItems(
              localOrder['items']
                  .map<CartItem>(
                    (item) => parseToCartItem(item),
                  )
                  .toList(),
            );
            localOrder['totalPrice'] += newItem.price;
            localOrder['cartLength'] += 1;
          }
          getTotalPrice(vendor);
          getCartLenth(vendor);
          getCurrentOrder(vendor);
        }
      },
    );
  }

  void removeItemFromCart(String vendor, CartItem newItem) {
    _localOrders.forEach(
      (localOrder) {
        if (localOrder['vendor'] == vendor) {
          localOrder['totalPrice'] -= newItem.price * newItem.quantity;
          localOrder['cartLength'] -= newItem.quantity;
          List<CartItem> items = localOrder['items']
              .map<CartItem>((item) => parseToCartItem(item))
              .toList();
          items.remove(newItem);

          localOrder['items'] = items.map((e) => e.toJson()).toList();

          changeCartItems(
            localOrder['items']
                .map<CartItem>(
                  (item) => parseToCartItem(item),
                )
                .toList(),
          );
          getCurrentOrder(vendor);
          getLocalOrder();
          getCartLenth(vendor);
          getCartsTotal();
          getTotalPrice(vendor);
        }
      },
    );
  }

  void increaseItemCount(String vendor, CartItem newItem) {
    _localOrders.forEach((localOrder) {
      if (localOrder['vendor'] == vendor) {
        localOrder['items'].forEach((item) {
          if (item['name'] == newItem.name) {
            item['quantity'] += 1;
            localOrder['totalPrice'] -= item['totalPrice'];
            item['totalPrice'] = item['quantity'] * item['price'];
            localOrder['totalPrice'] += item['totalPrice'];
            localOrder['cartLength'] += 1;
          }
        });
        getTotalPrice(vendor);
        getCartLenth(vendor);
        getCurrentOrder(vendor);
        getLocalOrder();
        getCartsTotal();
      }
    });
  }

  void decreaseItemCount(String vendor, CartItem newItem) {
    _localOrders.forEach((localOrder) {
      if (localOrder['vendor'] == vendor) {
        localOrder['items'].forEach((item) {
          if (item['name'] == newItem.name) {
            item['quantity'] -= 1;
            localOrder['totalPrice'] -= item['totalPrice'];
            item['totalPrice'] = item['quantity'] * item['price'];
            localOrder['totalPrice'] += item['totalPrice'];
            localOrder['cartLength'] -= 1;
          }
        });
        getTotalPrice(vendor);
        getCartLenth(vendor);
        getCurrentOrder(vendor);
        getLocalOrder();
        getCartsTotal();
      }
    });
  }

  getTotalPrice(String vendor) {
    _localOrders.forEach((order) {
      if (order['vendor'] == vendor) {
        _totalPrice = order['totalPrice'];
      }
    });
    changeTotalPrice(_totalPrice);
  }

  getCartsTotal() {
    _cartsTotal = _localOrders
        .map((order) => order['totalPrice'])
        .toList()
        .fold(0, (previousValue, element) => previousValue + element);
    changeCartsTotal(_cartsTotal);
  }

  getCartLenth(String vendor) {
    _localOrders.forEach((order) {
      if (order['vendor'] == vendor) {
        _totalLength = order['cartLength'];
      }
    });
    changeTotalLenght(_totalLength);
  }

  getCurrentOrder(String vendor) {
    _localOrders.forEach(
      (order) {
        if (order['vendor'] == vendor) {
          changeCurrentOrder(parseJsonToOnlineOrder(order));
          print(order);
        }
      },
    );
  }

  Future<void> saveOrder(
    Map<String, dynamic> user,
  ) async {
    _refID = UniqueKey().toString();
    return createRef({
      "vendors": _localOrders.map((e) => e['vendor']).toList(),
      "lat": _currentLocationSubject.value.latitude,
      "lang": _currentLocationSubject.value.longitude,
      "physicalLocation": _physicaLocation,
      "isAssignedTo": {
        "name": "",
        "email": "",
      },
      "refID": _refID,
      "user": user,
      "isPaid": false,
      "createdAt": DateTime.now().toIso8601String(),
      "totalCost": _localOrders
          .map((e) => e['totalPrice'])
          .toList()
          .fold(0, (previousValue, element) => previousValue + element),
      "deliveryCharge": 20,
    }).whenComplete(() {
      _localOrders.forEach((order) async {
        order['refID'] = _refID;
        await _repository.saveOrder(order);
      });
      _cleanUp();
    });
  }

  getDeliveryCharge() {
    // List<Map<String, dynamic>> locations = [];
    // const R = 6371000;
    // double lat1 = _currentLocationSubject.value.latitude;
    // double lat2 = 0;
    // double long1 = _currentLocationSubject.value.longitude;
    // double long2 = 0;
    // double longestDistance = 0.0;
    // _localOrders.forEach((localOrder) {
    //   _repository.getVendorLocation(localOrder['vendor']).listen((location) {
    //     // locations.add(location);
    //     lat2 = location['lat'];
    //     print(lat2);
    //     long2 = location['lang'];
    //     print(long2);
    //     double deltaLat1 = lat1 * (pi / 180);
    //     print(deltaLat1);
    //     double deltaLat2 = lat2 * (pi / 180);
    //     print(deltaLat2);
    //     double deltaLat = (lat2 - lat1) * (pi / 180);
    //     print(deltaLat);
    //     double deltaLong = (long2 - long1) * (pi / 180);
    //     print(deltaLong);
    //     double a = (sin(deltaLat / 2) * sin(deltaLat / 2)) +
    //         (cos(deltaLat1 / 2) * cos(deltaLat2 / 2)) +
    //         (sin(deltaLong / 2) * sin(deltaLong / 2));
    //     print(a);
    //     double c = atan2(sqrt(a), sqrt(1 - a));
    //     print(c);
    //     double distance = R * c;
    //     print(distance);
    //     if (distance > longestDistance) {
    //       longestDistance = distance;
    //       print(longestDistance / 1000);
    //     }
    //   });
    // });

    // locations.forEach((location) {});
    // changeDeliveryCharge(100 * longestDistance);
  }

  Future<void> createRef(Map<String, dynamic> refObj) {
    return _repository.createRefrence(refObj);
  }

  _cleanUp() {
    _localOrders = [];
    changeLocalOrders([]);
    changeCurrentOrder(null);
    changeTotalLenght(0);
    changeTotalPrice(0);
    changeCartsTotal(0);
    _totalPrice = 0;
    _totalLength = 0;
  }

  getLocalOrder() {
    changeLocalOrders(
        _localOrders.map((e) => parseJsonToOnlineOrder(e)).toList());
  }

  getCurrentLocation() {
    Location _location = Location();
    _location.getLocation().then((value) {
      print("This is the location: $value");
      changeCurrentLocation(value);
      getPhysicalLocation(value);
    });
  }

  getPhysicalLocation(LocationData location) async {
    final coordinates = new Coordinates(location.latitude, location.longitude);
    List<Address> addresses = [];
    print(coordinates);

    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var first = addresses.first;
    _physicaLocation = first.addressLine;
    changePhysicalLocation(first);
  }

  void dispose() {
    _cartItemsSubject.close();
    _liveOrdersSubject.close();
    _totalLengthSubject.close();
    _totalPriceSubject.close();
    _localOrderSubject.close();
    _currentOrderSubject.close();
    _currentLocationSubject.close();
    _physicalLocationSubject.close();
    _isSavingSubject.close();
    _currentLocationSubject.close();
    _cartItemsSubject.close();
    _cartsTotalSubject.close();
    _orderRefrenceSubject.close();
    _deliveryChargeSubject.close();
    _checkedOutSubject.close();
  }
}

OrderCartBloc orderCartBloc = OrderCartBloc();
