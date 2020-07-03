import 'dart:async';
import 'dart:io';

import 'package:fastuserapp/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class LoginBloc {
  final _repo = Repository();

  final BehaviorSubject<int> _userPhoneNumberSubject = BehaviorSubject<int>();
  Stream<int> get userPhoneNumber => _userPhoneNumberSubject.stream;
  Function(int) get change => _userPhoneNumberSubject.sink.add;

  final BehaviorSubject<String> _nameSubject = BehaviorSubject<String>();
  Stream<String> get name => _nameSubject.stream;
  Function(String) get changeName => _nameSubject.sink.add;

  final BehaviorSubject<String> _phoneNumberSubject = BehaviorSubject<String>();
  Stream<String> get phoneNumber => _phoneNumberSubject.stream;
  Function(String) get changePhoneNumber => _phoneNumberSubject.sink.add;

  saveUserNumber(int phoneNumber) {}

  Stream<FirebaseUser> get currentUserStateStream => _repo.onAuthStateChanged;

  signInWithGoogle() {
    _repo.googleSignIn();
  }

  Stream<bool> getUserStatus(String email) => _repo.getUserStatus(email);

  Stream<User> getUser(String email) => _repo.getUser(email);

  Stream<bool> canSubmitData() =>
      Rx.combineLatest2(name, phoneNumber, (a, b) => true);

  Future<void> saveUser(FirebaseUser user) async {
    var token = await user.getIdToken();
    return _repo.addUser(
      {
        "name": _nameSubject.value,
        "email": user.email,
        "UID": user.uid,
        "phoneNumber": int.parse(_phoneNumberSubject.value),
        "photoURI": user.photoUrl,
        "type": "client",
        "token": {
          "createdAt": DateTime.now().toIso8601String(),
          "token": token.token,
          "platform": Platform.operatingSystem,
        },
      },
    );
  }

  Future<void> signOut() => _repo.signOut();

  void dispose() {
    _userPhoneNumberSubject.close();
    _nameSubject.close();
    _phoneNumberSubject.close();
  }
}
