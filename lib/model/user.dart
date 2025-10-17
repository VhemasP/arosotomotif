class User {
  String email;
  String name;
  String phoneNumber;
  final bool isAdmin;

  User({
    required this.email,
    this.name = 'Pengguna Baru',
    this.phoneNumber = '',
    this.isAdmin = false,
  });
}