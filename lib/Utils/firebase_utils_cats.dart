import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_talk/Model/cats.dart';
import 'package:pharmacy_talk/Model/dogs.dart';

CollectionReference<Cats> getCatsFromFirebase() {
  return FirebaseFirestore.instance
      .collection('cats')
      .withConverter<Cats>(
          fromFirestore: (snapshot, options) =>
              Cats.fromJson(snapshot.data()!),
          toFirestore: (cats, options) => cats.toJson());
}

Future<void> deleteCatsFromFirebase(Cats book) {
  return getCatsFromFirebase().doc(book.id).delete();
}

Future<void> addCatsFireStore(Cats cats) {
  var collection = getCatsFromFirebase();
  var docRef = collection.doc();
  cats.id = docRef.id;
  return docRef.set(cats);
}
