// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Vendor> _$vendorSerializer = new _$VendorSerializer();

class _$VendorSerializer implements StructuredSerializer<Vendor> {
  @override
  final Iterable<Type> types = const [Vendor, _$Vendor];
  @override
  final String wireName = 'Vendor';

  @override
  Iterable<Object> serialize(Serializers serializers, Vendor object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.photoURI != null) {
      result
        ..add('photoURI')
        ..add(serializers.serialize(object.photoURI,
            specifiedType: const FullType(String)));
    }
    if (object.closeTime != null) {
      result
        ..add('closeTime')
        ..add(serializers.serialize(object.closeTime,
            specifiedType: const FullType(String)));
    }
    if (object.openTime != null) {
      result
        ..add('openTime')
        ..add(serializers.serialize(object.openTime,
            specifiedType: const FullType(String)));
    }
    if (object.minOrder != null) {
      result
        ..add('minOrder')
        ..add(serializers.serialize(object.minOrder,
            specifiedType: const FullType(int)));
    }
    if (object.physicalLocation != null) {
      result
        ..add('physicalLocation')
        ..add(serializers.serialize(object.physicalLocation,
            specifiedType: const FullType(String)));
    }
    if (object.lat != null) {
      result
        ..add('lat')
        ..add(serializers.serialize(object.lat,
            specifiedType: const FullType(double)));
    }
    if (object.lang != null) {
      result
        ..add('lang')
        ..add(serializers.serialize(object.lang,
            specifiedType: const FullType(double)));
    }
    if (object.averageRating != null) {
      result
        ..add('averageRating')
        ..add(serializers.serialize(object.averageRating,
            specifiedType: const FullType(double)));
    }
    if (object.tags != null) {
      result
        ..add('tags')
        ..add(serializers.serialize(object.tags,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.categories != null) {
      result
        ..add('categories')
        ..add(serializers.serialize(object.categories,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.isBusy != null) {
      result
        ..add('isBusy')
        ..add(serializers.serialize(object.isBusy,
            specifiedType: const FullType(bool)));
    }
    if (object.isAway != null) {
      result
        ..add('isAway')
        ..add(serializers.serialize(object.isAway,
            specifiedType: const FullType(bool)));
    }
    if (object.isFeatured != null) {
      result
        ..add('isFeatured')
        ..add(serializers.serialize(object.isFeatured,
            specifiedType: const FullType(bool)));
    }
    if (object.isNight != null) {
      result
        ..add('isNight')
        ..add(serializers.serialize(object.isNight,
            specifiedType: const FullType(bool)));
    }
    if (object.logoURL != null) {
      result
        ..add('logoURL')
        ..add(serializers.serialize(object.logoURL,
            specifiedType: const FullType(String)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Vendor deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'closeTime':
          result.closeTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'openTime':
          result.openTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'minOrder':
          result.minOrder = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'physicalLocation':
          result.physicalLocation = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lat':
          result.lat = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'lang':
          result.lang = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'averageRating':
          result.averageRating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tags':
          result.tags.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'categories':
          result.categories.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'isBusy':
          result.isBusy = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isAway':
          result.isAway = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isFeatured':
          result.isFeatured = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isNight':
          result.isNight = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'logoURL':
          result.logoURL = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Vendor extends Vendor {
  @override
  final String name;
  @override
  final String photoURI;
  @override
  final String closeTime;
  @override
  final String openTime;
  @override
  final int minOrder;
  @override
  final String physicalLocation;
  @override
  final double lat;
  @override
  final double lang;
  @override
  final double averageRating;
  @override
  final BuiltList<String> tags;
  @override
  final BuiltList<String> categories;
  @override
  final bool isBusy;
  @override
  final bool isAway;
  @override
  final bool isFeatured;
  @override
  final bool isNight;
  @override
  final String logoURL;
  @override
  final String id;

  factory _$Vendor([void Function(VendorBuilder) updates]) =>
      (new VendorBuilder()..update(updates)).build();

  _$Vendor._(
      {this.name,
      this.photoURI,
      this.closeTime,
      this.openTime,
      this.minOrder,
      this.physicalLocation,
      this.lat,
      this.lang,
      this.averageRating,
      this.tags,
      this.categories,
      this.isBusy,
      this.isAway,
      this.isFeatured,
      this.isNight,
      this.logoURL,
      this.id})
      : super._();

  @override
  Vendor rebuild(void Function(VendorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VendorBuilder toBuilder() => new VendorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Vendor &&
        name == other.name &&
        photoURI == other.photoURI &&
        closeTime == other.closeTime &&
        openTime == other.openTime &&
        minOrder == other.minOrder &&
        physicalLocation == other.physicalLocation &&
        lat == other.lat &&
        lang == other.lang &&
        averageRating == other.averageRating &&
        tags == other.tags &&
        categories == other.categories &&
        isBusy == other.isBusy &&
        isAway == other.isAway &&
        isFeatured == other.isFeatured &&
        isNight == other.isNight &&
        logoURL == other.logoURL &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        0,
                                                                        name
                                                                            .hashCode),
                                                                    photoURI
                                                                        .hashCode),
                                                                closeTime
                                                                    .hashCode),
                                                            openTime.hashCode),
                                                        minOrder.hashCode),
                                                    physicalLocation.hashCode),
                                                lat.hashCode),
                                            lang.hashCode),
                                        averageRating.hashCode),
                                    tags.hashCode),
                                categories.hashCode),
                            isBusy.hashCode),
                        isAway.hashCode),
                    isFeatured.hashCode),
                isNight.hashCode),
            logoURL.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Vendor')
          ..add('name', name)
          ..add('photoURI', photoURI)
          ..add('closeTime', closeTime)
          ..add('openTime', openTime)
          ..add('minOrder', minOrder)
          ..add('physicalLocation', physicalLocation)
          ..add('lat', lat)
          ..add('lang', lang)
          ..add('averageRating', averageRating)
          ..add('tags', tags)
          ..add('categories', categories)
          ..add('isBusy', isBusy)
          ..add('isAway', isAway)
          ..add('isFeatured', isFeatured)
          ..add('isNight', isNight)
          ..add('logoURL', logoURL)
          ..add('id', id))
        .toString();
  }
}

class VendorBuilder implements Builder<Vendor, VendorBuilder> {
  _$Vendor _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _photoURI;
  String get photoURI => _$this._photoURI;
  set photoURI(String photoURI) => _$this._photoURI = photoURI;

  String _closeTime;
  String get closeTime => _$this._closeTime;
  set closeTime(String closeTime) => _$this._closeTime = closeTime;

  String _openTime;
  String get openTime => _$this._openTime;
  set openTime(String openTime) => _$this._openTime = openTime;

  int _minOrder;
  int get minOrder => _$this._minOrder;
  set minOrder(int minOrder) => _$this._minOrder = minOrder;

  String _physicalLocation;
  String get physicalLocation => _$this._physicalLocation;
  set physicalLocation(String physicalLocation) =>
      _$this._physicalLocation = physicalLocation;

  double _lat;
  double get lat => _$this._lat;
  set lat(double lat) => _$this._lat = lat;

  double _lang;
  double get lang => _$this._lang;
  set lang(double lang) => _$this._lang = lang;

  double _averageRating;
  double get averageRating => _$this._averageRating;
  set averageRating(double averageRating) =>
      _$this._averageRating = averageRating;

  ListBuilder<String> _tags;
  ListBuilder<String> get tags => _$this._tags ??= new ListBuilder<String>();
  set tags(ListBuilder<String> tags) => _$this._tags = tags;

  ListBuilder<String> _categories;
  ListBuilder<String> get categories =>
      _$this._categories ??= new ListBuilder<String>();
  set categories(ListBuilder<String> categories) =>
      _$this._categories = categories;

  bool _isBusy;
  bool get isBusy => _$this._isBusy;
  set isBusy(bool isBusy) => _$this._isBusy = isBusy;

  bool _isAway;
  bool get isAway => _$this._isAway;
  set isAway(bool isAway) => _$this._isAway = isAway;

  bool _isFeatured;
  bool get isFeatured => _$this._isFeatured;
  set isFeatured(bool isFeatured) => _$this._isFeatured = isFeatured;

  bool _isNight;
  bool get isNight => _$this._isNight;
  set isNight(bool isNight) => _$this._isNight = isNight;

  String _logoURL;
  String get logoURL => _$this._logoURL;
  set logoURL(String logoURL) => _$this._logoURL = logoURL;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  VendorBuilder();

  VendorBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _photoURI = _$v.photoURI;
      _closeTime = _$v.closeTime;
      _openTime = _$v.openTime;
      _minOrder = _$v.minOrder;
      _physicalLocation = _$v.physicalLocation;
      _lat = _$v.lat;
      _lang = _$v.lang;
      _averageRating = _$v.averageRating;
      _tags = _$v.tags?.toBuilder();
      _categories = _$v.categories?.toBuilder();
      _isBusy = _$v.isBusy;
      _isAway = _$v.isAway;
      _isFeatured = _$v.isFeatured;
      _isNight = _$v.isNight;
      _logoURL = _$v.logoURL;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Vendor other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Vendor;
  }

  @override
  void update(void Function(VendorBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Vendor build() {
    _$Vendor _$result;
    try {
      _$result = _$v ??
          new _$Vendor._(
              name: name,
              photoURI: photoURI,
              closeTime: closeTime,
              openTime: openTime,
              minOrder: minOrder,
              physicalLocation: physicalLocation,
              lat: lat,
              lang: lang,
              averageRating: averageRating,
              tags: _tags?.build(),
              categories: _categories?.build(),
              isBusy: isBusy,
              isAway: isAway,
              isFeatured: isFeatured,
              isNight: isNight,
              logoURL: logoURL,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
        _$failedField = 'categories';
        _categories?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Vendor', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
