class Profile{
  final int? id;
  final String name;
  final String email;

  Profile({ this.id, required this.name, required this.email});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email
    };
  }
  
}