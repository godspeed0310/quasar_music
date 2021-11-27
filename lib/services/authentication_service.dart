import 'package:firebase_auth/firebase_auth.dart';
import 'package:quasar_music/locator.dart';
import 'package:quasar_music/models/user_model.dart';
import 'package:quasar_music/services/firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //Create user in firestore
      await _firestoreService.createUser(
        UserModel(
          uid: authResult.user!.uid,
          email: email,
        ),
      );

      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser;
    return user != null;
  }
}
