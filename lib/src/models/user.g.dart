// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<User> _$userSerializer = new _$UserSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable<Object> serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
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
    if (object.phoneNumber != null) {
      result
        ..add('phoneNumber')
        ..add(serializers.serialize(object.phoneNumber,
            specifiedType: const FullType(int)));
    }
    if (object.home != null) {
      result
        ..add('home')
        ..add(serializers.serialize(object.home,
            specifiedType: const FullType(UserLocation)));
    }
    if (object.office != null) {
      result
        ..add('office')
        ..add(serializers.serialize(object.office,
            specifiedType: const FullType(UserLocation)));
    }
    if (object.isVerified != null) {
      result
        ..add('isVerified')
        ..add(serializers.serialize(object.isVerified,
            specifiedType: const FullType(bool)));
    }
    if (object.promoCodes != null) {
      result
        ..add('promoCodes')
        ..add(serializers.serialize(object.promoCodes,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phoneNumber':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'home':
          result.home.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserLocation)) as UserLocation);
          break;
        case 'office':
          result.office.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserLocation)) as UserLocation);
          break;
        case 'isVerified':
          result.isVerified = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'promoCodes':
          result.promoCodes.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$User extends User {
  @override
  final String email;
  @override
  final String name;
  @override
  final String photoURI;
  @override
  final int phoneNumber;
  @override
  final UserLocation home;
  @override
  final UserLocation office;
  @override
  final bool isVerified;
  @override
  final BuiltList<String> promoCodes;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.email,
      this.name,
      this.photoURI,
      this.phoneNumber,
      this.home,
      this.office,
      this.isVerified,
      this.promoCodes})
      : super._();

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        email == other.email &&
        name == other.name &&
        photoURI == other.photoURI &&
        phoneNumber == other.phoneNumber &&
        home == other.home &&
        office == other.office &&
        isVerified == other.isVerified &&
        promoCodes == other.promoCodes;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, email.hashCode), name.hashCode),
                            photoURI.hashCode),
                        phoneNumber.hashCode),
                    home.hashCode),
                office.hashCode),
            isVerified.hashCode),
        promoCodes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('email', email)
          ..add('name', name)
          ..add('photoURI', photoURI)
          ..add('phoneNumber', phoneNumber)
          ..add('home', home)
          ..add('office', office)
          ..add('isVerified', isVerified)
          ..add('promoCodes', promoCodes))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _photoURI;
  String get photoURI => _$this._photoURI;
  set photoURI(String photoURI) => _$this._photoURI = photoURI;

  int _phoneNumber;
  int get phoneNumber => _$this._phoneNumber;
  set phoneNumber(int phoneNumber) => _$this._phoneNumber = phoneNumber;

  UserLocationBuilder _home;
  UserLocationBuilder get home => _$this._home ??= new UserLocationBuilder();
  set home(UserLocationBuilder home) => _$this._home = home;

  UserLocationBuilder _office;
  UserLocationBuilder get office =>
      _$this._office ??= new UserLocationBuilder();
  set office(UserLocationBuilder office) => _$this._office = office;

  bool _isVerified;
  bool get isVerified => _$this._isVerified;
  set isVerified(bool isVerified) => _$this._isVerified = isVerified;

  ListBuilder<String> _promoCodes;
  ListBuilder<String> get promoCodes =>
      _$this._promoCodes ??= new ListBuilder<String>();
  set promoCodes(ListBuilder<String> promoCodes) =>
      _$this._promoCodes = promoCodes;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _email = _$v.email;
      _name = _$v.name;
      _photoURI = _$v.photoURI;
      _phoneNumber = _$v.phoneNumber;
      _home = _$v.home?.toBuilder();
      _office = _$v.office?.toBuilder();
      _isVerified = _$v.isVerified;
      _promoCodes = _$v.promoCodes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    _$User _$result;
    try {
      _$result = _$v ??
          new _$User._(
              email: email,
              name: name,
              photoURI: photoURI,
              phoneNumber: phoneNumber,
              home: _home?.build(),
              office: _office?.build(),
              isVerified: isVerified,
              promoCodes: _promoCodes?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'home';
        _home?.build();
        _$failedField = 'office';
        _office?.build();

        _$failedField = 'promoCodes';
        _promoCodes?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'User', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
