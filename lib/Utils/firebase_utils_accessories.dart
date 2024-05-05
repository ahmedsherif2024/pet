import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_talk/Model/birds.dart';
import 'package:pharmacy_talk/model/accessories.dart';

CollectionReference<Accessories> getAccessoriesFromFirebase() {
  return FirebaseFirestore.instance
      .collection('accessories')
      .withConverter<Accessories>(
      fromFirestore: (snapshot, options) =>
          Accessories.fromJson(snapshot.data()!),
      toFirestore: (accessories, options) => accessories.toJson());
}

Future<void> deletetAccessoriesFromFirebase(Accessories book) {
  return getAccessoriesFromFirebase().doc(book.id).delete();
}

Future<void> addAccessoriesFireStore(Accessories accessories) {
  var collection = getAccessoriesFromFirebase();
  var docRef = collection.doc();
  accessories.id = docRef.id;
  return docRef.set(accessories);
}
