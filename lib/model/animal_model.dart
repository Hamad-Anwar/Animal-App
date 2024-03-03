import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalModel {
  AnimalModel(
      {required this.name,
      required this.owner,
      required this.distance,
      required this.images,
      required this.location,
      required this.price});

  final String name;
  final String location;
  final String distance;
  final String price;
  final Owner owner;
  final List<String> images;
  factory AnimalModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return AnimalModel(
      name: data['name'],
      location: data['location'],
      distance: data['distance'],
      price: data['price'],
      owner: Owner(
        name: data['owner']['name'],
        id: data['owner']['id'],
        date: data['owner']['date'],
      ),
      images: List<String>.from(data['images']),
    );
  }
}

class Owner {
  Owner({required this.name, required this.date, required this.id});

  final String name;
  final String id;
  final String date;
}
