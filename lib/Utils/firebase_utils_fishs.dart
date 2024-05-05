import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_talk/Model/dogs.dart';
import 'package:pharmacy_talk/Model/fish.dart';

CollectionReference<Fishs> getFishsFromFirebase() {
  return FirebaseFirestore.instance
      .collection('fishs')
      .withConverter<Fishs>(
          fromFirestore: (snapshot, options) =>
              Fishs.fromJson(snapshot.data()!),
          toFirestore: (fishs, options) => fishs.toJson());
}

Future<void> deleteFishsFromFirebase(Fishs book) {
  return getFishsFromFirebase().doc(book.id).delete();
}

Future<void> addFishsFireStore(Fishs fishs) {
  var collection = getFishsFromFirebase();
  var docRef = collection.doc();
  fishs.id = docRef.id;
  return docRef.set(fishs);
}
