class UserModel {
  final String? name;
  final String? age;
  final String? phoneNumber;
  final String? token;
  final String? email;
  final String? location;
  final List<dynamic> nearestLocations;
  UserModel(
      {required this.name,
      required this.age,
      required  this.nearestLocations,
        required this.token,
      required this.location,
      required this.email,
      required this.phoneNumber,
      });
}
