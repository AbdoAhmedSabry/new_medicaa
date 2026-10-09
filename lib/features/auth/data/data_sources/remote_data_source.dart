import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_medicaa/features/auth/data/models/user_model.dart';
import 'package:new_medicaa/features/auth/domain/entities/user_entity.dart';

class FirebaseAuthServic {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthServic(this._firebaseAuth);

  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User user = credential.user!;
    return UserEntity(
      uid: user.uid,
      email: user.email!,
      name: user.displayName ?? "",
      phone: user.phoneNumber ?? "",
    );
  }

  Future<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User user = credential.user!;

    final userProfile = UserModel(
      uid: user.uid,
      email: user.email!,
      name: name,
      phone: phone,
      photoURL: user.photoURL,
    );
    if (!user.emailVerified) {
      await user.sendEmailVerification();
      print("Verification email sent");
    }
    return userProfile;
  }

  Future<void> forgotPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserEntity> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    final User user = userCredential.user!;
    return UserEntity(
      uid: user.uid,
      email: user.email!,
      name: user.displayName ?? "",
      phone: user.phoneNumber ?? "",
    );
  }

  Future<UserEntity> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        facebookAuthCredential,
      );

      final User user = userCredential.user!;

      return UserEntity(
        uid: user.uid,
        email: user.email ?? "",
        name: user.displayName ?? "",
        phone: user.phoneNumber ?? "",
      );
    } else {
      throw (
        message: 'Facebook login failed or cancelled: ${loginResult.message}',
      );
    }
  }

  Future<void> delatUser() async {
    await _firebaseAuth.currentUser!.delete();
  }
}
