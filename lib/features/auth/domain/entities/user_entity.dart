class UserEntity {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final String? photoURL;

  UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    this.photoURL,
  });
}
