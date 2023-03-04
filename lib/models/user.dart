// ignore_for_file: public_member_api_docs, sort_constructors_first
class BidUser {
  final String email;
  final String password;

  BidUser(this.email, this.password);
}

class User {
  final String email;
  final String lastName;
  final String firstName;
  final String address;
  final String username;
  final String phone;
  final int id;
  User({
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.username,
    required this.id,
  });
}
