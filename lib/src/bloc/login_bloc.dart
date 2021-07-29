import 'dart:async';
import 'dart:io';

import 'package:fastuserapp/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class LoginBloc {
  final _repo = Repository();
  String _name = "";
  String _phoneNumber = "";

  final BehaviorSubject<String> _nameSubject = BehaviorSubject<String>();
  Stream<String> get name => _nameSubject.stream.transform(
        StreamTransformer.fromHandlers(
          handleData: (String name, sink) {
            if (name.isNotEmpty && !name.contains("  ")) {
              sink.add(name);
            } else {
              sink.addError("Enter a valid name.");
            }
          },
        ),
      );
  Function(String) get changeName => _nameSubject.sink.add;

  final BehaviorSubject<String> _phoneNumberSubject = BehaviorSubject<String>();
  Stream<String> get phoneNumber => _phoneNumberSubject.stream.transform(
          StreamTransformer.fromHandlers(handleData: (String number, sink) {
        if (!(number.length > 10) && !(number.length < 10)) {
          sink.add(number);
        } else {
          sink.addError("Enter a valid number");
        }
      }));

  final BehaviorSubject<Map<String, dynamic>> _homeLocationSubject =
      BehaviorSubject<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get homeLocation => _homeLocationSubject.stream;
  Function(Map<String, dynamic>) get changeHomeLocation =>
      _homeLocationSubject.sink.add;
  Function(String) get changePhoneNumber => _phoneNumberSubject.sink.add;

  final BehaviorSubject<Map<String, dynamic>> _officeLocationSubject =
      BehaviorSubject<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get officeLocation =>
      _officeLocationSubject.stream;
  Function(Map<String, dynamic>) get changeOfficeLocation =>
      _officeLocationSubject.sink.add;

  saveUserNumber(int phoneNumber) {}

  Stream<User> get currentUserStateStream => _repo.onAuthStateChanged;

  signInWithGoogle() {
    try {
      _repo.googleSignIn().then(
        (value) async {
          var token = await FirebaseMessaging().getToken();
          await _repo.saveUserToken(
            value.email,
            {
              "createdAt": DateTime.now().toIso8601String(),
              "token": token,
              "platform": Platform.operatingSystem,
            },
          );
        },
      );
    } catch (e) {
      print("Error:$e");
    }
  }

  signInWithApple() {
    _repo.appleSignIn().then(
      (value) async {
        var token = await FirebaseMessaging().getToken();
        await _repo.saveUserToken(
          value.email,
          {
            "createdAt": DateTime.now().toIso8601String(),
            "token": token,
            "platform": Platform.operatingSystem,
          },
        );
      },
    );
  }

  isAppleSignInAvailable() => _repo.isAppleSiginInAvailable();

  Stream<bool> getUserStatus(String email) => _repo.getUserStatus(email);

  Stream<FastUser> getUser(String email) => _repo.getUser(email);

  Stream<bool> get canSubmitData => Rx.combineLatest2<String, String, bool>(
        name,
        phoneNumber,
        (String name, String phoneNumber) {
          _name = name;
          _phoneNumber = phoneNumber;
          if (_name.isNotEmpty && _phoneNumber.isNotEmpty) {
            print("name: $_name");
            return true;
          }
          return null;
        },
      );

  void printUser() {
    print(
      {
        "name": _name,
        // "email": user.email,
        // "UID": user.uid,
        "promoCodes": [],
      },
    );
  }

  Future<void> saveUser(User user) async {
    var token = await FirebaseMessaging().getToken();
    return _repo.addUser(
      {
        "name": _name,
        "email": user.email,
        "UID": user.uid,
        "promoCodes": [],
        "phoneNumber": int.parse(_phoneNumber),
        "photoURI": user.photoURL,
        "type": "client",
        "home": _homeLocationSubject.value != null
            ? {
                "lat": _homeLocationSubject.value['lat'],
                "lang": _homeLocationSubject.value['lang'],
                "physicalLocation":
                    _homeLocationSubject.value['physicalLocation'],
              }
            : {},
        "office": _officeLocationSubject.value != null
            ? {
                "lat": _officeLocationSubject.value['lat'],
                "lang": _officeLocationSubject.value['lang'],
                "physicalLocation":
                    _officeLocationSubject.value['physicalLocation'],
              }
            : {},
      },
    ).then(
      (value) async {
        if (token == null) {
          token = await FirebaseMessaging().getToken();
        }
        await _repo.saveUserToken(
          user.email,
          {
            "createdAt": DateTime.now().toIso8601String(),
            "token": token,
            "platform": Platform.operatingSystem,
          },
        );
      },
    );
  }

  Future<void> signOut() => _repo.signOut();

  Future<void> updateUserHomeLocation(
          Map<String, dynamic> home, String email) =>
      _repo.updateUserHomeLocation(
        home: home,
        email: email,
      );

  Future<void> updateUserOfficeLocation(
          Map<String, dynamic> office, String email) =>
      _repo.updateUserOfficeLocation(
        office: office,
        email: email,
      );

  Future<void> profileImageUpdater(String email, String type) async {
    final _picker = ImagePicker();
    final _galleryImage = await _picker.getImage(
      source: type == "gallery" ? ImageSource.gallery : ImageSource.camera,
    );
    // changeImagePath(_galleryImage.path);
    final _imageTask = await _repo.savePhoto(
        File(_galleryImage.path), basename(File(_galleryImage.path).path));
    if (_imageTask.error != null) return;
    final downloadString = await _imageTask.ref.getDownloadURL();
    _repo.updateProfilePicture(
      email,
      downloadString,
    );
  }

  void dispose() {
    _nameSubject.close();
    _phoneNumberSubject.close();
    _homeLocationSubject.close();
    _officeLocationSubject.close();
  }
}
