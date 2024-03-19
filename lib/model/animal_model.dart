import 'package:animal/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalPostModel {
  AnimalPostModel(
      {
    required this.id,
        this.name,
        this.age,
        this.price,
        this.description,
        this.address,
        this.noOfChildProduced,
        required this.images,
        required this.owner,
        this.milkInKg,
});

  final String id;
  final String? name;
  final String? age;
  final String? price;
  final String? milkInKg;
  final String? noOfChildProduced;
  final String? address;
  final String? description;
  final Owner owner;
  final List<String> images;

  factory AnimalPostModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return AnimalPostModel(
      id: data['id'],
      name: data['name'],
      age: data['age'],
      price: data['price'],
      milkInKg: data['milkInKg'],
      noOfChildProduced: data['noOfChildProduced'],
      address: data['address'],
      description: data['description'],
      owner: Owner(
        name: data['owner']['name'],
        contact: data['owner']['contact'],
        id: data['owner']['id'],
        date: data['owner']['date'],
        profilePicture: data['owner']['profilePicture'],
      ),
      images: List<String>.from(data['images']),
    );
  }
}

class Owner {
  Owner({required this.name, required this.date, required this.id,this.profilePicture,required this.contact});
  final String name;
  final String id;
  final String contact;
  final String date;
  final String? profilePicture;
}
