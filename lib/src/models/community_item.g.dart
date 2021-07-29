// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CommunityItem> _$communityItemSerializer =
    new _$CommunityItemSerializer();

class _$CommunityItemSerializer implements StructuredSerializer<CommunityItem> {
  @override
  final Iterable<Type> types = const [CommunityItem, _$CommunityItem];
  @override
  final String wireName = 'CommunityItem';

  @override
  Iterable<Object> serialize(Serializers serializers, CommunityItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.title != null) {
      result
        ..add('title')
        ..add(serializers.serialize(object.title,
            specifiedType: const FullType(String)));
    }
    if (object.city != null) {
      result
        ..add('city')
        ..add(serializers.serialize(object.city,
            specifiedType: const FullType(String)));
    }
    if (object.closeTime != null) {
      result
        ..add('closeTime')
        ..add(serializers.serialize(object.closeTime,
            specifiedType: const FullType(String)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.photoURI != null) {
      result
        ..add('photoURI')
        ..add(serializers.serialize(object.photoURI,
            specifiedType: const FullType(String)));
    }
    if (object.physicalLocation != null) {
      result
        ..add('physicalLocation')
        ..add(serializers.serialize(object.physicalLocation,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  CommunityItem deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommunityItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'closeTime':
          result.closeTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'physicalLocation':
          result.physicalLocation = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CommunityItem extends CommunityItem {
  @override
  final String title;
  @override
  final String city;
  @override
  final String closeTime;
  @override
  final String description;
  @override
  final String photoURI;
  @override
  final String physicalLocation;

  factory _$CommunityItem([void Function(CommunityItemBuilder) updates]) =>
      (new CommunityItemBuilder()..update(updates)).build();

  _$CommunityItem._(
      {this.title,
      this.city,
      this.closeTime,
      this.description,
      this.photoURI,
      this.physicalLocation})
      : super._();

  @override
  CommunityItem rebuild(void Function(CommunityItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommunityItemBuilder toBuilder() => new CommunityItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommunityItem &&
        title == other.title &&
        city == other.city &&
        closeTime == other.closeTime &&
        description == other.description &&
        photoURI == other.photoURI &&
        physicalLocation == other.physicalLocation;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, title.hashCode), city.hashCode),
                    closeTime.hashCode),
                description.hashCode),
            photoURI.hashCode),
        physicalLocation.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CommunityItem')
          ..add('title', title)
          ..add('city', city)
          ..add('closeTime', closeTime)
          ..add('description', description)
          ..add('photoURI', photoURI)
          ..add('physicalLocation', physicalLocation))
        .toString();
  }
}

class CommunityItemBuilder
    implements Builder<CommunityItem, CommunityItemBuilder> {
  _$CommunityItem _$v;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _city;
  String get city => _$this._city;
  set city(String city) => _$this._city = city;

  String _closeTime;
  String get closeTime => _$this._closeTime;
  set closeTime(String closeTime) => _$this._closeTime = closeTime;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _photoURI;
  String get photoURI => _$this._photoURI;
  set photoURI(String photoURI) => _$this._photoURI = photoURI;

  String _physicalLocation;
  String get physicalLocation => _$this._physicalLocation;
  set physicalLocation(String physicalLocation) =>
      _$this._physicalLocation = physicalLocation;

  CommunityItemBuilder();

  CommunityItemBuilder get _$this {
    if (_$v != null) {
      _title = _$v.title;
      _city = _$v.city;
      _closeTime = _$v.closeTime;
      _description = _$v.description;
      _photoURI = _$v.photoURI;
      _physicalLocation = _$v.physicalLocation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommunityItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CommunityItem;
  }

  @override
  void update(void Function(CommunityItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CommunityItem build() {
    final _$result = _$v ??
        new _$CommunityItem._(
            title: title,
            city: city,
            closeTime: closeTime,
            description: description,
            photoURI: photoURI,
            physicalLocation: physicalLocation);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
