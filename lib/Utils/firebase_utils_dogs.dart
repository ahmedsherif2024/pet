import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_talk/Model/dogs.dart';

CollectionReference<Dogs> getDogs() {
  return FirebaseFirestore.instance
      .collection('dogs')
      .withConverter<Dogs>(
      fromFirestore: ((snapshot, options) =>
          Dogs.fromJson(snapshot.data()!)),
      toFirestore: (dogs, options) => dogs.toJson());
}
Future<void> addDogsFireStore(Dogs dogs) {
  var collection = getDogs();
  var docRef = collection.doc();
  dogs.id = docRef.id;
  return docRef.set(dogs);
}
