import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

import '../models/order_ref.dart';
import '../models/cart_items.dart';
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

  final BehaviorSubject<List<OrderRef>> _closedRefrenceSubject =
      BehaviorSubject<List<OrderRef>>();
  Stream<List<OrderRef>> get closedRefrence => _closedRefrenceSubject.stream;
  Function(List<OrderRef>) get changeClosedRefrences =>
      _closedRefrenceSubject.sink.add;

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

  final BehaviorSubject<double> _cartsTotalSubject = BehaviorSubject<double>();
  Stream<double> get cartsTotal => _cartsTotalSubject.stream;
  Function(double) get changeCartsTotal => _cartsTotalSubject.sink.add;

  final BehaviorSubject<Map<String, dynamic>> _currentLocationSubject =
      BehaviorSubject<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get currentLocation =>
      _currentLocationSubject.stream;
  Function(Map<String, dynamic>) get changeCurrentLocation =>
      _currentLocationSubject.sink.add;
  final BehaviorSubject<String> _physicalLocationSubject =
      BehaviorSubject<String>();
  Stream<String> get physicalLocation => _physicalLocationSubject.stream;
  Function(String) get changePhysicalLocation =>
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

  final BehaviorSubject<bool> _transactionStatusSubject =
      BehaviorSubject<bool>();
  Stream<bool> get transactionStatus => _transactionStatusSubject.stream;
  Function(bool) get changeTransactionStatus =>
      _transactionStatusSubject.sink.add;

  final BehaviorSubject<String> _userPhoneNumberSubject =
      BehaviorSubject<String>();
  Stream<String> get userPhoneNumber => _userPhoneNumberSubject.stream;
  Function(String) get changeUserPhoneNumber =>
      _userPhoneNumberSubject.sink.add;

  final BehaviorSubject<Map<String, dynamic>> _checkoutCoordinatesSubject =
      BehaviorSubject<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get checkoutCoordinates =>
      _checkoutCoordinatesSubject.stream;
  Function(Map<String, dynamic>) get changeChkeckoutCoordinates =>
      _checkoutCoordinatesSubject.sink.add;
  final BehaviorSubject<String> _checkoutPhysicalLocationSubject =
      BehaviorSubject<String>();
  Stream<String> get checkoutPhysicalLocation =>
      _checkoutPhysicalLocationSubject.stream;
  Function(String) get changeCheckoutPhysicalLocation =>
      _checkoutPhysicalLocationSubject.sink.add;

  final BehaviorSubject<bool> _isScheduledSubject = BehaviorSubject<bool>();
  Stream<bool> get isScheduled => _isScheduledSubject.stream;
  Function(bool) get changeSchedulingStatus => _isScheduledSubject.sink.add;

  final BehaviorSubject<String> _scheduledTimeSubject =
      BehaviorSubject<String>();
  Stream<String> get scheduledTime => _scheduledTimeSubject.stream;
  Function(String) get changeScheduledTime => _scheduledTimeSubject.sink.add;

  final BehaviorSubject<String> _promoCodeSubject = BehaviorSubject<String>();
  Stream<String> get promoCode => _promoCodeSubject.stream.transform(
          StreamTransformer.fromHandlers(handleData: (String promoCode, sink) {
        if (promoCode.isNotEmpty) {
          sink.add(promoCode);
        } else {
          sink.addError("Add a vlaid Code");
        }
      }));
  Function(String) get changePromoCode => _promoCodeSubject.sink.add;

  final BehaviorSubject<bool> _promoCodeIsUsedSubject = BehaviorSubject<bool>();
  Stream<bool> get promoCodeIsUsed => _promoCodeIsUsedSubject.stream;
  Function(bool) get changePromoUsedStateUsed =>
      _promoCodeIsUsedSubject.sink.add;

  String get orderRefrenceID => _refID;

  OrderCartBloc() {
    changeTotalLenght(0);
    changeTotalPrice(0);
    changeSavingStatus(false);
    changeCheckoutStatus(false);
    getCurrentLocation();
    changeTransactionStatus(false);
    changePromoUsedStateUsed(false);
    changeSchedulingStatus(false);
  }

  getOrderRefs(Map<String, dynamic> user) {
    _repository.getOrderRefs(user).listen(
      (orderRefs) {
        changeOrderRefrence(orderRefs);
        print(orderRefs);
      },
    );
  }

  getClosedOrderRefs(Map<String, dynamic> user) {
    _repository.getClosedOrderRefs(user).listen((closedRef) {
      changeClosedRefrences(closedRef);
    });
  }

  Future<void> deleteOrderRef(String refID) =>
      _repository.deleteOrderRefs(refID);

  getOrders(String refID) {
    _repository.getOrders(refID).listen((orders) {
      changeLiveOrders(orders);
    });
  }

  void addNewOrder(BuildContext context, String vendor, CartItem newItem,
      Map<String, dynamic> user, int minOrder) {
    if (_checkedOutSubject.value == true) {
      changeCheckoutStatus(false);
    }
    if (_promoCodeIsUsedSubject.value == true) {
      changeCheckoutStatus(false);
    }
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
          "minOrder": minOrder,
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
    getCartsTotal();
  }

  applyPromoCode(String email) {
    _repository.getUser(email).listen(
      (user) {
        if (user.promoCodes.contains(_promoCodeSubject.value)) {
          changePromoUsedStateUsed(true);
        } else {
          _repository.getPromoCode(_promoCodeSubject.value).listen(
            (disRate) async {
              _cartsTotal = _localOrders
                  .map((order) => order['totalPrice'])
                  .toList()
                  .fold(0, (previousValue, element) => previousValue + element);
              changeCartsTotal(_cartsTotal - (_cartsTotal * (disRate / 100)));
              await _repository.addPromoCode(
                email,
                _promoCodeSubject.value,
                user.promoCodes.toList(),
              );
              changePromoUsedStateUsed(true);
            },
          );
        }
      },
    );
  }

  void addItemsToCart(String vendor, CartItem newItem) {
    _localOrders.forEach(
      (localOrder) {
        if (localOrder['vendor'] == vendor) {
          if (localOrder['items'].isEmpty) {
            localOrder['items'].add(
              newItem.toJson(),
            );
            changeCartItems(
              localOrder['items']
                  .map<CartItem>(
                    (item) => parseToCartItem(item),
                  )
                  .toList(),
            );
            localOrder['totalPrice'] += newItem.totalPrice;
            localOrder['cartLength'] += newItem.quantity;
          } else if (localOrder['items']
              .map(
                (item) => item['name'],
              )
              .toList()
              .contains(newItem.name)) {
            localOrder['items'].forEach((item) {
              if (item['name'] == newItem.name) {
                item['quantity'] += newItem.quantity;
                localOrder['totalPrice'] -= item['totalPrice'];
                item['totalPrice'] = item['quantity'] * item['price'];
                localOrder['totalPrice'] += item['totalPrice'];
                localOrder['cartLength'] += newItem.quantity;
              }
            });
          } else {
            localOrder['items'].add(
              newItem.toJson(),
            );
            changeCartItems(
              localOrder['items']
                  .map<CartItem>(
                    (item) => parseToCartItem(item),
                  )
                  .toList(),
            );
            localOrder['totalPrice'] += newItem.totalPrice;
            localOrder['cartLength'] += newItem.quantity;
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
    changeCartsTotal(_cartsTotal.toDouble());
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
      "lat": _checkoutCoordinatesSubject.value['lat'],
      "lang": _checkoutCoordinatesSubject.value['lang'],
      "physicalLocation": _checkoutPhysicalLocationSubject.value,
      "status": [],
      "isScheduled": _isScheduledSubject.value,
      "scheduleTime": _scheduledTimeSubject.value != null
          ? _scheduledTimeSubject.value
          : "",
      "isAssignedTo": {
        "name": "",
        "email": "",
      },
      "refID": _refID,
      "user": {
        "name": user['name'],
        "email": user['email'],
      },
      "isPaid": false,
      "isDelivered": false,
      "createdAt": DateTime.now().toIso8601String(),
      "totalCost": _cartsTotalSubject.value + _deliveryChargeSubject.value,
      "deliveryCharge": _deliveryChargeSubject.value,
    }).whenComplete(() {
      _localOrders.forEach((order) async {
        order['refID'] = _refID;
        await _repository.saveOrder(order);
      });
      _cleanUp();
    });
  }

  getDeliveryCharge() {
    double farthestLocation = 0.0;
    double addableAmount = 20.0;
    Distance _distance = Distance();

    _localOrders.forEach((order) {
      _repository.getVendorLocation(order['vendor']).listen((latlong) {
        double distance = _distance.as(
            LengthUnit.Meter,
            LatLng(_checkoutCoordinatesSubject.value['lat'],
                _checkoutCoordinatesSubject.value['lang']),
            LatLng(latlong['lat'], latlong['lang']));
        print("Distance: $distance");
        if (distance > farthestLocation) {
          farthestLocation = distance;
        }
        print("Farthest Location: $farthestLocation");
        if (farthestLocation > 5000.0) {
          _repository.getDistanceRates().listen((rates) {
            addableAmount += (farthestLocation - 2000) * (rates.first / 1000);
            print("Addabe Amount:$addableAmount");
            changeDeliveryCharge(addableAmount);
          });
        } else {
          changeDeliveryCharge(
            addableAmount,
          );
        }
      });
    });

    // print("Farthest Location: $farthestLocation");
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
      changeCurrentLocation(
        {"lat": value.latitude, "lang": value.longitude},
      );
      getPhysicalLocation(
        {"lat": value.latitude, "lang": value.longitude},
      );
    });
  }

  getChangedLocation(Map<String, dynamic> location) {
    if (location != null) {
      changeCurrentLocation(
        {"lat": location['lat'], "lang": location['lang']},
      );
      getPhysicalLocation(
        {"lat": location['lat'], "lang": location['lang']},
      );
    } else {
      getCurrentLocation();
    }
  }

  getCheckoutLocation(
      {Map<String, dynamic> coordinates, String phycialLocation}) {
    if (coordinates == null && phycialLocation == null) {
      changeChkeckoutCoordinates(_currentLocationSubject.value);
      changeCheckoutPhysicalLocation(_physicalLocationSubject.value);
    } else {
      changeChkeckoutCoordinates(coordinates);
      changeCheckoutPhysicalLocation(phycialLocation);
    }
  }

  getPhysicalLocation(Map<String, dynamic> location,
      {String addressLine}) async {
    if (addressLine == null) {
      final coordinates = Coordinates(location['lat'], location['lang']);

      List<Address> addresses = [];
      print(coordinates);
      try {
        addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        _physicaLocation = first.addressLine;
        changePhysicalLocation(first.addressLine);
      } catch (e) {
        print(e);
      }
    } else {
      changePhysicalLocation(addressLine);
    }
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
