class UpdateProfileRequest {
  final String firstName;
  final String lastName;
  final String country;
  final int jerseyNumber;
  final String gender;
  final String team;
  final String instagram;
  final String position;
  final String image;

  UpdateProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.jerseyNumber,
    required this.gender,
    required this.team,
    required this.instagram,
    required this.position,
    required this.image,
  });

  // Factory method to create an instance from a JSON map
  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    return UpdateProfileRequest(
      firstName: json['first_name'],
      lastName: json['last_name'],
      country: json['country'],
      jerseyNumber: json['jersey_number'],
      gender: json['gender'],
      team: json['team'],
      instagram: json['instagram'],
      position: json['position'],
      image: json['image'],
    );
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'country': country,
      'jersey_number': jerseyNumber,
      'gender': gender,
      'team': team,
      'instagram': instagram,
      'position': position,
      'image': image,
    };
  }
}
