import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deldart/core/services/firebase/firebse_constant.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updatePostData({
    required String collectionReference,
    required Map<String, dynamic> data,
    required Map<String, dynamic> afterSlug,
  }) async {
    CollectionReference postsCollection = _firestore.collection(FireBaseConstants.postCollection);
    DocumentReference documentReference = postsCollection.doc(collectionReference);
    await documentReference.set(afterSlug, SetOptions(merge: true));
    documentReference.collection(FireBaseConstants.postCollection).add(data);
  }
}
