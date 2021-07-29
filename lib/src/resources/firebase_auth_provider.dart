import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthProvider {
  final _firebaseAuthInstance = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Stream<User> get onAuthStateChanged =>
      _firebaseAuthInstance.authStateChanges();

  Future<UserCredential> createUser(String email, String password) {
    return _firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> login(String email, String password) {
    return _firebaseAuthInstance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _firebaseAuthInstance.signInWithCredential(credential);
    final User user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _firebaseAuthInstance.currentUser;
    assert(user.uid == currentUser.uid);

    return user;
  }

  Future<bool> get appleSignInAvailable => AppleSignIn.isAvailable();

  Future<FirebaseUser> appleSignIn() async {
    try {
      final AuthorizationResult appleResult =
          await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      if (appleResult.error != null) {
        // handle errors from Apple here
      }

      final AuthCredential credential = OAuthProvider('apple.com').credential(
        accessToken:
            String.fromCharCodes(appleResult.credential.authorizationCode),
        idToken: String.fromCharCodes(appleResult.credential.identityToken),
      );

      UserCredential firebaseResult =
          await _firebaseAuthInstance.signInWithCredential(credential);
      User user = firebaseResult.user;

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  signInWithApple() async {
    // final credential = await SignInWithApple.getAppleIDCredential(
    //   scopes: [
    //     AppleIDAuthorizationScopes.email,
    //     AppleIDAuthorizationScopes.fullName,
    //   ],
    //   webAuthenticationOptions: WebAuthenticationOptions(
    //     clientId: 'com.fast977.fastuserapp.icanBMTS.debug.service',
    //     redirectUri: Uri.parse(
    //       'https://fast-d2857.firebaseapp.com/__/auth/handler',
    //     ),
    //   ),
    //   // nonce: 'example-nonce',
    //   // state: 'example-state',
    // );
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
  //     ),0000000000000000000000000000000000

  //     // TODO: Remove these if you have no need for them
  //     // nonce: 'example-nonce',
  //     // state: 'example-state',
  //   );
  // }

  Future<void> signOut() {
    return _firebaseAuthInstance.signOut();
  }
}
