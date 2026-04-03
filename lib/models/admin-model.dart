class AdminFillable {
  static const String table = 'admins';

  static const String id = 'id';
  static const String password = 'password';
}

class Admin {
  int? id;
  String? password;

  Admin({this.id, this.password});

  Map<String, dynamic> toMap() => {
    AdminFillable.id: id,
    AdminFillable.password: password,
  };

  factory Admin.fromMap(Map<String, dynamic> map) =>
      Admin(id: map[AdminFillable.id], password: map[AdminFillable.password]);
}
