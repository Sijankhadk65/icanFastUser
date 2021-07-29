import 'package:hive/hive.dart';

class HiveProvider {
  Box _hiveBoxProvider;

  Future<Box> openBox() {
    return Hive.openBox("localOrders");
  }

  closeBox() {
    _hiveBoxProvider.close();
  }
}
