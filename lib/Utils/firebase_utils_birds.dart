import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_talk/Model/birds.dart';
import 'package:pharmacy_talk/Model/dogs.dart';

CollectionReference<Birds> getBirdsFromFirebase() {
  return FirebaseFirestore.instance
      .collection('birds')
      .withConverter<Birds>(
          fromFirestore: (snapshot, options) =>
              Birds.fromJson(snapshot.data()!),
          toFirestore: (birds, options) => birds.toJson());
}

Future<void> deletetBirdsFromFirebase(Birds book) {
  return getBirdsFromFirebase().doc(book.id).delete();
}

Future<void> addBirdsFireStore(Birds birds) {
  var collection = getBirdsFromFirebase();
  var docRef = collection.doc();
  birds.id = docRef.id;
  return docRef.set(birds);
}
