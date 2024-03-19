import 'package:animal/main.dart';
import 'package:animal/utils/emun_filters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/animal_model.dart';

class FirebaseServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> addPost({required AnimalPostModel post, required String type}) async {
    Map<String, dynamic> postData = {
      'id': post.id,
      'timestamp' : DateTime.now().microsecondsSinceEpoch.toString(),
      'name': post.name,
      'age': post.age,
      'address': post.address,
      'price': post.price,
      'milkInKg': post.milkInKg,
      'noOfChildProduced': post.noOfChildProduced,
      'description': post.description,
      'owner': {
        'name': post.owner.name,
        'id': post.owner.id,
        'contact' : post.owner.contact,
        'date': post.owner.date,
        'profilePicture': post.owner.profilePicture,
      },
      'images': post.images,
    };

    _db.collection('animal_posts').doc(post.id).set(postData);
    await _db.collection('${type.toLowerCase()}_${user!.nearestLocations[0].toString()}').doc(post.id).set(postData);
  }

  Future<List<AnimalPostModel>> getAnimals({required PostFilters filter,required String location}) async {
    final querySnapshot = await _db.collection(filter == PostFilters.all ? 'animal_posts' : 'animal_$location')
        .orderBy('timestamp', descending: true)
        .get();
    return querySnapshot.docs.map((doc) => AnimalPostModel.fromFirestore(doc)).toList();
  }

  Future<List<AnimalPostModel>> getFarms() async {
    QuerySnapshot snapshot = await _db.collection('farms').get();
    return snapshot.docs.map((doc) => AnimalPostModel.fromFirestore(doc)).toList();
  }
}