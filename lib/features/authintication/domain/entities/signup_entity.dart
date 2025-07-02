class SignupEntity {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String userId;
  const SignupEntity(this.userId, {required this.firstname,required this.lastname,required this.email,required this.password});
}