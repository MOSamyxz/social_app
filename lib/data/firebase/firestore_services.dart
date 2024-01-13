import 'package:chatapp/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Users> getUserDetails({
    required String collection,
    required String doc,
  }) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection(collection).doc(doc).get();

    Users user = Users.fromFirestore(documentSnapshot);
    return user;
  }
}
