library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fastuserapp/src/models/add_on.dart';
import 'package:fastuserapp/src/models/carousel_item.dart';
import 'package:fastuserapp/src/models/liquor.dart';
import 'package:fastuserapp/src/models/offers_item.dart';
import 'package:fastuserapp/src/models/promo_code.dart';
import 'package:fastuserapp/src/models/varient.dart';
import '../models/order_ref.dart';
import '../models/rating.dart';
import '../models/user.dart';
import '../models/vendor.dart';

import './cart_items.dart';
import './item.dart';
import './online_order.dart';
import './user_location.dart';

part 'serializer.g.dart';

@SerializersFor(
  const [
    CartItem,
    OnlineOrder,
    FastUser,
    MenuItem,
    Vendor,
    OrderRef,
    Rating,
    CarouselItem,
    OffersItem,
    UserLocation,
    Liquor,
    AddOn,
    Varient,
    PromoCode,
  ],
)
final Serializers serializers = _$serializers;
final jsonSerializer = (serializers.toBuilder()
      ..addPlugin(
        StandardJsonPlugin(),
      ))
    .build();
