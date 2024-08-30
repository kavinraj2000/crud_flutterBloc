class User {
  final String id;
  final String name;
  final String email;
  final String phonenumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phonenumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String? ?? '', // Default to empty string if null
      name: json['name'] as String? ?? '', // Default to empty string if null
      email: json['email'] as String? ?? '', // Default to empty string if null
      phonenumber: json['phonenumber'] as String? ??
          '', // Default to empty string if null
    );
  }
}
