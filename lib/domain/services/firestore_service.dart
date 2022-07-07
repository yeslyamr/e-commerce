import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_store_app/domain/models/product.dart';

abstract class CloudFirestoreService {
  Future<void> postPublication({required Product product});

  Future<void> deletePublication({required DocumentReference docRef});

  Query<Map<String, dynamic>> getPublicationsFromFirestore(
      QueryDocumentSnapshot<Object?>? lastVis);

  Future<List<dynamic>> getMyPublications(); // [done]

  Future<void> addToCart({required DocumentReference docRef});

  Future<void> removeFromCart({required DocumentReference docRef});

  Future<void> purchaseCart(
      {required List<DocumentSnapshot> documentSnapshots});
}

class CloudFirestoreServiceImpl implements CloudFirestoreService {
  @override
  Future<void> deletePublication({required DocumentReference docRef}) async {
    // remove from db
    await docRef.delete();

    // remove from myPubl
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    await user.update({
      'myPublications': FieldValue.arrayRemove([docRef])
    });
  }

  @override
  Future<void> postPublication({required Product product}) async {
    final jsonPro = product.toJson();
    final autoIdDoc = await FirebaseFirestore.instance
        .collection('publications')
        .add(jsonPro);

    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    await user.update({
      'myPublications': FieldValue.arrayUnion([autoIdDoc])
    });
  }

  @override
  Future<void> addToCart({required DocumentReference docRef}) async {
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    await user.update({
      'cart': FieldValue.arrayUnion([docRef])
    });
  }

  @override
  Future<void> purchaseCart(
      {required List<DocumentSnapshot> documentSnapshots}) async {
    final purchasesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('purchases');

    for (DocumentSnapshot docSnap in documentSnapshots) {
      await purchasesCollection.add(docSnap.data() as Map<String, dynamic>);
      deletePublication(docRef: docSnap.reference);
    }
  }

  @override
  Query<Map<String, dynamic>> getPublicationsFromFirestore(
      QueryDocumentSnapshot<Object?>? lastVis) {
    if (lastVis != null) {
      final next = FirebaseFirestore.instance
          .collection("publications")
          .orderBy("price")
          .startAfterDocument(lastVis)
          .limit(10);

      return next;
    } else {
      final first = FirebaseFirestore.instance
          .collection("publications")
          .orderBy("price")
          .limit(10);
      return first;
    }
  }

  @override
  Future<List<dynamic>> getMyPublications() async {
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    final myPublications = (await user.get()).get('myPublications');
    return myPublications as List<dynamic>;
  }

  @override
  Future<void> removeFromCart(
      {required DocumentReference<Object?> docRef}) async {
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    await user.update({
      'cart': FieldValue.arrayRemove([docRef])
    });
  }
}
