import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quasar_music/models/song_model.dart';
import 'package:quasar_music/models/user_model.dart';

class FirestoreService {
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference favRef =
      FirebaseFirestore.instance.collection('favourites');

  Future createUser(UserModel user) async {
    try {
      await userRef.doc(user.uid).set(
            user.toJson(),
          );
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await userRef.doc(uid).get();
      return UserModel.fromData(userData.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future addToFav(SongModel songModel, String uid) async {
    try {
      return await userRef.doc(uid).update(
        {
          'favourites': FieldValue.arrayUnion(
            [
              songModel.toMap(),
            ],
          ),
        },
      );
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future removeFromFav(SongModel songModel, String uid) async {
    try {
      return await userRef.doc(uid).update(
        {
          'favourites': FieldValue.arrayRemove(
            [
              songModel.toMap(),
            ],
          ),
        },
      );
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
