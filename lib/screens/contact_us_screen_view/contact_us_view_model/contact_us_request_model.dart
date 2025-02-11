class ContactUsRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String message;

  ContactUsRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'message': message,
    };
  }
}
