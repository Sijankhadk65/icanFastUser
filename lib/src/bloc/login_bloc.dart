import 'dart:async';
import 'dart:io';

import 'package:fastuserapp/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Function(String) get changePhoneNumber => _phoneNumberSubject.sink.add;

  saveUserNumber(int phoneNumber) {}

  Stream<FirebaseUser> get currentUserStateStream => _repo.onAuthStateChanged;

  signInWithGoogle() {
    _repo.googleSignIn();
  }

  Stream<bool> getUserStatus(String email) => _repo.getUserStatus(email);

  Stream<User> getUser(String email) => _repo.getUser(email);

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

  Future<void> saveUser(FirebaseUser user) async {
    // var token = await FirebaseMessaging().getToken();
    return _repo.addUser(
      {
        "name": _name,
        "email": user.email,
        "UID": user.uid,
        "phoneNumber": int.parse(_phoneNumber),
        "photoURI": user.photoUrl,
        "type": "client",
        "token": {
          "createdAt": DateTime.now().toIso8601String(),
          // "token": token,
          "platform": Platform.operatingSystem,
        },
      },
    );
  }

  Future<void> signOut() => _repo.signOut();

  void dispose() {
    _nameSubject.close();
    _phoneNumberSubject.close();
  }
}
