import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

  // loginWithApple() async {
  //   final authCredential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //     webAuthenticationOptions: WebAuthenticationOptions(
  //       clientId: 'ccom.fast977.fastuserapp.icanBMTS.debug.service',
  //       redirectUri: Uri.parse(
  //         'https://fast-d2857.firebaseapp.com/__/auth/handler',
  //       ),
  //     ),
  //     // TODO: Remove these if you have no need for them
  //     // nonce: 'example-nonce',
  //     // state: 'example-state',
  //   );
  // }

  Future<void> signOut() {
    return _firebaseAuthInstance.signOut();
  }
}
