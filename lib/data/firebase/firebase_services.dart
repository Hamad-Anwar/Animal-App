import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/animal_model.dart';

class FirebaseServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> addPost({required PostModel post,required String type}) {
    return _db.collection(type).add({
      'name': post.name,
      'location': post.location,
      'distance': post.distance,
      'price': post.price,
      'owner': {
        'name': post.owner.name,
        'id': post.owner.id,
        'date': post.owner.date,
      },
      'images': post.images,
    });
  }

  Future<List<PostModel>> getAnimals() async {
    QuerySnapshot snapshot = await _db.collection('animal').get();
    return snapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList();
  }
  Future<List<PostModel>> getFarms() async {
    QuerySnapshot snapshot = await _db.collection('farms').get();
    return snapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList();
  }
}