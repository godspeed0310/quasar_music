import 'package:firebase_auth/firebase_auth.dart';
import 'package:quasar_music/locator.dart';
import 'package:quasar_music/models/user_model.dart';
import 'package:quasar_music/services/firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  late UserModel _currentUser;
  UserModel get currentUser => _currentUser;

  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user != null) {
        await _populateUser(authResult.user!);
      }
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
      _currentUser = UserModel(
        uid: authResult.user!.uid,
        email: email,
      );
      await _firestoreService.createUser(_currentUser);

      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser;
    if (user != null) {
      await _populateUser(user);
    }
    return user != null;
  }

  Future _populateUser(User user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }
}
