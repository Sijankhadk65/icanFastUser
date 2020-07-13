import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import '../models/serializer.dart';
import '../models/user.dart';

part 'order_ref.g.dart';

abstract class OrderRef implements Built<OrderRef, OrderRefBuilder> {
  @nullable
  double get totalCost;
  @nullable
  User get user;
  @nullable
  String get refID;
  @nullable
  double get deliveryCharge;
  @nullable
  String get createdAt;
  @nullable
  BuiltList<String> get status;
  @nullable
  BuiltList<String> get vendors;
  @nullable
  String get physicalLocation;
  @nullable
  User get isAssignedTo;
  @nullable
  double get lat;
  @nullable
  double get lang;
  OrderRef._();
  factory OrderRef([updates(OrderRefBuilder b)]) = _$OrderRef;
  static Serializer<OrderRef> get serializer => _$orderRefSerializer;
}

OrderRef parseJsonToOrderRef(Map<String, dynamic> json) =>
    jsonSerializer.deserializeWith(OrderRef.serializer, json);
