class SignUpModel {
  String? email;

  String? password;
  String? phone;

  String? name;

  SignUpModel(
      {required this.email,
      required this.password,
      required this.phone,
      required this.name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['f_name'] = this.name;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['email'] = this.email;

    return data;
  }
}
