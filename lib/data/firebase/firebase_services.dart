import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/animal_model.dart';

class FirebaseServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> addAnimal(AnimalModel animal) {
    return _db.collection('animals').add({
      'name': animal.name,
      'location': animal.location,
      'distance': animal.distance,
      'price': animal.price,
      'owner': {
        'name': animal.owner.name,
        'id': animal.owner.id,
        'date': animal.owner.date,
      },
      'images': animal.images,
    });
  }

  Future<List<AnimalModel>> getAnimals() async {
    QuerySnapshot snapshot = await _db.collection('animals').get();
    return snapshot.docs.map((doc) => AnimalModel.fromFirestore(doc)).toList();
  }
}