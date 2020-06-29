import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthProvider {
  final _firebaseAuthInstance = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Stream<FirebaseUser> get onAuthStateChanged =>
      _firebaseAuthInstance.onAuthStateChanged;

  Future<AuthResult> createUser(String email, String password) {
    return _firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<AuthResult> login(String email, String password) {
    return _firebaseAuthInstance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult =
        await _firebaseAuthInstance.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuthInstance.currentUser();
    assert(user.uid == currentUser.uid);

    return user;
  }

  Future<void> signOut() {
    return _firebaseAuthInstance.signOut();
  }
}
