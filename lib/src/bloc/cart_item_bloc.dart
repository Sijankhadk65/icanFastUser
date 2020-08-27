import 'package:fastuserapp/src/models/add_on.dart';
import 'package:fastuserapp/src/models/varient.dart';
import 'package:rxdart/rxdart.dart';

class CartItemBloc {
  List<AddOn> _selectedAddOns = [];

  final BehaviorSubject<Varient> _currentSelectedVarientSubject =
      BehaviorSubject<Varient>();
  Stream<Varient> get currentSelectedVarient =>
      _currentSelectedVarientSubject.stream;
  Function(Varient) get changeCurrentSelectedVarient =>
      _currentSelectedVarientSubject.sink.add;

  final BehaviorSubject<double> _currentUnitPriceSubject =
      BehaviorSubject<double>();
  Stream<double> get currentUnitPrice => _currentUnitPriceSubject.stream;
  Function(double) get changeCurrentUnitPrice =>
      _currentUnitPriceSubject.sink.add;

  final BehaviorSubject<double> _currentTotalPriceSubject =
      BehaviorSubject<double>();
  Stream<double> get currentTotalPrice => _currentTotalPriceSubject.stream;
  Function(double) get changeCurrentTotalPrice =>
      _currentTotalPriceSubject.sink.add;

  final BehaviorSubject<double> _currentItemCountSubject =
      BehaviorSubject<double>();
  Stream<double> get currentItemCount => _currentItemCountSubject.stream;
  Function(double) get changeCurrentItemCount =>
      _currentItemCountSubject.sink.add;

  final BehaviorSubject<List<AddOn>> _currentSelectedAddonsSubject =
      BehaviorSubject<List<AddOn>>();
  Stream<List<AddOn>> get currentSelectedAddons =>
      _currentSelectedAddonsSubject.stream;
  Function(List<AddOn>) get changeCurrentSelectedAddons =>
      _currentSelectedAddonsSubject.sink.add;

  changeTotalPrice() {
    changeCurrentTotalPrice(
        _currentItemCountSubject.value * _currentUnitPriceSubject.value);
  }

  manageAddOn(AddOn addOn) {
    if (_currentSelectedAddonsSubject.value.contains(addOn)) {
      changeCurrentUnitPrice(
          _currentUnitPriceSubject.value - addOn.price.toDouble());
      changeTotalPrice();
      _selectedAddOns.remove(addOn);
      changeCurrentSelectedAddons(_selectedAddOns);
    } else {
      changeCurrentUnitPrice(
          _currentUnitPriceSubject.value + addOn.price.toDouble());
      changeTotalPrice();
      _selectedAddOns.add(addOn);
      changeCurrentSelectedAddons(_selectedAddOns);
    }
  }

  Map<String, dynamic> getItem(String itemName) => {
        "name": itemName,
        "totalPrice": _currentTotalPriceSubject.value,
        "quantity": _currentItemCountSubject.value,
        "price": _currentUnitPriceSubject.value,
        "addOns": _currentSelectedAddonsSubject.value
            .map(
              (addOn) => addOn.toNewAddOnJson(),
            )
            .toList(),
        "varient": _currentSelectedVarientSubject.value.toNewVarientJson(),
      };

  dispose() {
    _currentSelectedVarientSubject.close();
    _currentUnitPriceSubject.close();
    _currentTotalPriceSubject.close();
    _currentItemCountSubject.close();
    _currentSelectedAddonsSubject.close();
  }
}
