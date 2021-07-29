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
  String _scheduledTime = "";
  List<String> _promoCodesUsed = [];
  // String _physicaLocation = "";

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
        StreamTransformer.fromHandlers(
          handleData: (String promoCode, sink) {
            if (promoCode.isNotEmpty) {
              sink.add(promoCode);
            } else {
              sink.addError("Add a vlaid Code");
            }
          },
        ),
      );
  Function(String) get changePromoCode => _promoCodeSubject.sink.add;
  final BehaviorSubject<Map<String, dynamic>> _promoCodeMessageSubject =
      BehaviorSubject<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get promoCodeMessage =>
      _promoCodeMessageSubject.stream;
  Function(Map<String, dynamic>) get changePromoCodesMessage =>
      _promoCodeMessageSubject.sink.add;
  final BehaviorSubject<bool> _promoCodeIsUsedSubject = BehaviorSubject<bool>();
  Stream<bool> get promoCodeIsUsed => _promoCodeIsUsedSubject.stream;
  Function(bool) get changePromoUsedStateUsed =>
      _promoCodeIsUsedSubject.sink.add;

  String get orderRefrenceID => _refID;

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
    _transactionStatusSubject.close();
    _userPhoneNumberSubject.close();
    _checkoutCoordinatesSubject.close();
    _isScheduledSubject.close();
    _checkoutPhysicalLocationSubject.close();
    _scheduledTimeSubject.close();
    _promoCodeSubject.close();
    _promoCodeIsUsedSubject.close();
    _closedRefrenceSubject.close();
  }

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

  Stream<List<OrderRef>> getOrderRefs(Map<String, dynamic> user, String type) {
    print("The Type is $type");
    if (type == "open") {
      return _repository.getOrderRefs(user);
    } else {
      return _repository.getClosedOrderRefs(user);
    }
  }

  Future<void> deleteOrderRef(String refID) =>
      _repository.deleteOrderRefs(refID);

  getOrders(String refID) {
    _repository.getOrders(refID).listen((orders) {
      changeLiveOrders(orders);
    });
  }

  void addNewOrder(BuildContext context,
      {String vendor,
      CartItem newItem,
      String vendorID,
      Map<String, dynamic> user,
      bool shouldSchedule,
      bool isNight,
      DateTime openingTime,
      DateTime closingTime,
      int minOrder}) {
    if (shouldSchedule == true) {
      var orderScheduleTime = "";
      if (_scheduledTime != "") {
        if (openingTime.hour > DateTime.parse(_scheduledTime).hour) {
          if (DateTime.now().hour < 12) {
            orderScheduleTime = getOrderScheduleTime(
              openingTime: openingTime,
              increaseDay: 0,
              increaseHour: 1,
            ).toIso8601String();
          } else {
            orderScheduleTime = getOrderScheduleTime(
              openingTime: openingTime,
              increaseDay: 1,
              increaseHour: 1,
            ).toIso8601String();
          }
        }
      } else {
        if (DateTime.now().hour < 12) {
          orderScheduleTime = getOrderScheduleTime(
            openingTime: openingTime,
            increaseDay: 0,
            increaseHour: 1,
          ).toIso8601String();
        } else {
          orderScheduleTime = getOrderScheduleTime(
            openingTime: openingTime,
            increaseDay: 1,
            increaseHour: 1,
          ).toIso8601String();
        }
      }
      changeScheduledTime(orderScheduleTime);
      changeSchedulingStatus(true);
      print("The Scheduled Time:${_scheduledTimeSubject.value}");
    }
    if (_checkedOutSubject.value == true) {
      changeCheckoutStatus(false);
    }
    if (_promoCodeIsUsedSubject.value == true) {
      changeCheckoutStatus(false);
    }
    if (!_localOrders.map((e) => e['vendor']).toList().contains(
          vendorID,
        )) {
      _localOrders.add(
        {
          "vendor": vendorID,
          "vendorName": vendor,
          "items": [],
          "totalPrice": 0,
          "createdAt": DateTime.now().toIso8601String(),
          "status": [],
          "cartLength": 0,
          "minOrder": minOrder,
          "promoCodes": []
        },
      );
      addItemsToCart(vendor: vendorID, newItem: newItem);
      changeLocalOrders(
          _localOrders.map((order) => parseJsonToOnlineOrder(order)).toList());
    } else {
      addItemsToCart(vendor: vendorID, newItem: newItem);
      changeLocalOrders(
          _localOrders.map((order) => parseJsonToOnlineOrder(order)).toList());
    }
    getCartsTotal();
    print(_localOrders);
  }

  DateTime getOrderScheduleTime(
      {DateTime openingTime, int increaseDay = 0, int increaseHour = 0}) {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + increaseDay,
      openingTime.hour + increaseHour,
      0,
      0,
      0,
      0,
    );
  }

  applyPromoCode(String email) {
    double _cartsTotal = 0;
    _repository.getUser(email).listen(
      (user) {
        if (user.promoCodes.contains(_promoCodeSubject.value)) {
          changePromoCodesMessage(
            {
              "priority": "error",
              "message": "You've already used this code.",
            },
          );
        } else {
          _repository.getPromoCode(_promoCodeSubject.value).listen(
            (promoCode) async {
              if (promoCode.vendors.isEmpty) {
                _cartsTotal = _localOrders
                    .map((order) => order['totalPrice'])
                    .toList()
                    .fold(
                      0,
                      (
                        previousValue,
                        element,
                      ) =>
                          previousValue + element,
                    );

                _localOrders.forEach(
                  (order) {
                    order['promoCodes'] = [
                      ...order['promoCodes'],
                      _promoCodeSubject.value,
                    ];
                  },
                );
                _cartsTotal -= _cartsTotal * (promoCode.rate / 100);
                changeCartsTotal(
                  _cartsTotal,
                );
                changeLocalOrders(
                  _localOrders
                      .map((order) => parseJsonToOnlineOrder(order))
                      .toList(),
                );
                await _repository.addPromoCode(
                  email,
                  _promoCodeSubject.value,
                  user.promoCodes.toList(),
                );
                changePromoCodesMessage({
                  "priority": "success",
                  "message": "This was succefully used.",
                });
                changePromoUsedStateUsed(true);
              } else {
                if (elementChecker(
                    _localOrders.map((order) => order['vendor']).toList(),
                    promoCode.vendors.toList())) {
                  promoCode.vendors.forEach(
                    (vendor) {
                      _localOrders.forEach(
                        (order) {
                          if (order['vendor'] == vendor) {
                            order['promoCodes'] = [
                              ...order['promoCodes'],
                              _promoCodeSubject.value,
                            ];
                            order['totalPrice'] -=
                                order['totalPrice'] * (promoCode.rate / 100);
                          }
                        },
                      );
                    },
                  );
                  _cartsTotal = _localOrders
                      .map((order) => order['totalPrice'])
                      .toList()
                      .fold(
                        0,
                        (previousValue, element) => previousValue + element,
                      );
                  changeLocalOrders(
                    _localOrders
                        .map((order) => parseJsonToOnlineOrder(order))
                        .toList(),
                  );
                  changeCartsTotal(
                    _cartsTotal,
                  );
                  await _repository.addPromoCode(
                    email,
                    _promoCodeSubject.value,
                    user.promoCodes.toList(),
                  );
                  changePromoCodesMessage({
                    "priority": "success",
                    "message": "This was succefully used.",
                  });
                  changePromoUsedStateUsed(true);
                } else {
                  changePromoCodesMessage(
                    {
                      "priority": "warning",
                      "message":
                          "This code is not valid for this set of vendors.",
                    },
                  );
                }
              }
            },
          );
        }
      },
    );
  }

  bool elementChecker(List source, List target) =>
      target.every((v) => source.contains(v));

  void addItemsToCart({String vendor, CartItem newItem}) {
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
        }
      },
    );
    getTotalPrice(vendor);
    getCartLenth(vendor);
    getCurrentOrder(vendor);
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

    if (_localOrders
            .where((element) => element['vendor'] == vendor)
            .toList()
            .first['items']
            .toString() ==
        "[]") {
      removeCart(vendor);
    }
  }

  void increaseItemCount(String vendor, CartItem newItem) {
    _localOrders.forEach(
      (localOrder) {
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
      },
    );
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
    _localOrders.forEach(
      (order) {
        if (order['vendor'] == vendor) {
          _totalPrice = order['totalPrice'];
        }
      },
    );
    changeTotalPrice(_totalPrice);
  }

  getCartsTotal() {
    _cartsTotal = _localOrders
        .map((order) => order['totalPrice'])
        .toList()
        .fold(0, (previousValue, element) => previousValue + element);
    changeCartsTotal(
      _cartsTotal.toDouble(),
    );
  }

  getCartLenth(String vendor) {
    _localOrders.forEach(
      (order) {
        if (order['vendor'] == vendor) {
          _totalLength = order['cartLength'];
        }
      },
    );
    changeTotalLenght(_totalLength);
  }

  getCurrentOrder(String vendor) {
    _localOrders.forEach(
      (order) {
        if (order['vendor'] == vendor) {
          changeCurrentOrder(parseJsonToOnlineOrder(order));
          print("Current Order:${order.toString()}");
        }
      },
    );
  }

  Future<void> saveOrder(
    Map<String, dynamic> user,
  ) async {
    _refID = UniqueKey().toString();
    return createRef(
      {
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
        "isPromoCodeUsed": _promoCodeIsUsedSubject.value ?? false,
      },
    ).whenComplete(
      () {
        _localOrders.forEach(
          (order) async {
            order['refID'] = _refID;
            await _repository.saveOrder(order);
          },
        );
        _cleanUp();
      },
    );
  }

  removeCart(String vendorName) {
    _localOrders.removeWhere((cart) => cart['vendor'] == vendorName);

    getLocalOrder();
    getCurrentOrder(null);
  }

  getDeliveryCharge() {
    double farthestLocation = 0.0;
    double addableAmount = 20.0;
    Distance _distance = Distance();

    if (_localOrders.length == 1 && _localOrders.first['vendor'] == "Liquor") {
      double distance = _distance.as(
        LengthUnit.Meter,
        LatLng(_checkoutCoordinatesSubject.value['lat'],
            _checkoutCoordinatesSubject.value['lang']),
        LatLng(27.704015260871312, 83.46299696713686),
      );

      if (distance >= 5000) {
        _repository.getDistanceRates().listen(
          (rates) {
            addableAmount += (distance - 5000) * (rates.first / 1000);

            changeDeliveryCharge(addableAmount);
          },
        );
      } else {
        changeDeliveryCharge(
          addableAmount,
        );
      }
    } else {
      _localOrders.forEach((order) {
        _repository.getVendorLocation(order['vendor']).listen((latlong) {
          double distance = _distance.as(
              LengthUnit.Meter,
              LatLng(_checkoutCoordinatesSubject.value['lat'],
                  _checkoutCoordinatesSubject.value['lang']),
              LatLng(latlong['lat'], latlong['lang']));

          if (distance > farthestLocation) {
            farthestLocation = distance;
          }
          if (farthestLocation > 5000.0) {
            _repository.getDistanceRates().listen(
              (rates) {
                addableAmount +=
                    (farthestLocation - 5000) * (rates.first / 1000);

                changeDeliveryCharge(addableAmount);
              },
            );
          } else {
            changeDeliveryCharge(
              addableAmount,
            );
          }
        });
      });
    }
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

  getCheckoutLocation(Map<String, dynamic> location) {
    print("Input Location: $location");
    if (location == null) {
      changeChkeckoutCoordinates(
        _currentLocationSubject.value,
      );
      changeCheckoutPhysicalLocation(
        _physicalLocationSubject.value,
      );
    } else {
      changeChkeckoutCoordinates(
        location['coordinates'],
      );
      changeCheckoutPhysicalLocation(
        location['physicalLocation'],
      );
    }
    print("Location;${_checkoutPhysicalLocationSubject.value}");
  }

  getPhysicalLocation(Map<String, dynamic> location,
      {String addressLine}) async {
    if (addressLine == null) {
      final coordinates = Coordinates(location['lat'], location['lang']);

      List<Address> addresses = [];

      try {
        addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        changePhysicalLocation(first.addressLine);
      } catch (e) {}
    } else {
      changePhysicalLocation(addressLine);
    }
  }

  // // For DataBase usage
  // openDB() => _repository.openDB();

  // closeDB() => _repository.closeDB();
}

OrderCartBloc orderCartBloc = OrderCartBloc();
