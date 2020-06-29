import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class LoginBloc {
  final _repo = Repository();

  final BehaviorSubject<int> _userPhoneNumberSubject = BehaviorSubject<int>();
  Stream<int> get userPhoneNumber => _userPhoneNumberSubject.stream;
  Function(int) get change => _userPhoneNumberSubject.sink.add;

  saveUserNumber(int phoneNumber) {}

  Stream<FirebaseUser> get currentUserStateStream => _repo.onAuthStateChanged;

  signInWithGoogle() {
    _repo.googleSignIn().then(
          (user) => {
            _repo.addUser(
              {
                "name": user.displayName,
                "email": user.email,
                "photoUrl": user.photoUrl,
                "UID": user.uid,
                "phoneNumber": user.phoneNumber
              },
            )
          },
        );
  }

  Future<void> signOut() => _repo.signOut();

  void dispose() {
    _userPhoneNumberSubject.close();
  }
}
