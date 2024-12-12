class User {
  int? id;
  String? nik;
  String? username;
  String? email;
  String? name;
  String? role;
  String? phone;
  String? hireDate;
  String? emailVerifiedAt;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? taskType;
  String? keterangan;
  String? signature;
  String? jabatan;
  int? loginAtk;
  int? loginIzin;
  int? loginEvent;
  int? loginCa;

  User(
      {this.id,
      this.nik,
      this.username,
      this.email,
      this.name,
      this.role,
      this.phone,
      this.hireDate,
      this.emailVerifiedAt,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.taskType,
      this.keterangan,
      this.signature,
      this.jabatan,
      this.loginAtk,
      this.loginIzin,
      this.loginEvent,
      this.loginCa});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    role = json['role'];
    phone = json['phone'];
    hireDate = json['hire_date'];
    emailVerifiedAt = json['email_verified_at'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    taskType = json['task_type'];
    keterangan = json['keterangan'];
    signature = json['signature'];
    jabatan = json['jabatan'];
    loginAtk = json['login_atk'];
    loginIzin = json['login_izin'];
    loginEvent = json['login_event'];
    loginCa = json['login_ca'];
  }

  Map<String, dynamic> toJson(User user) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nik'] = nik;
    data['username'] = username;
    data['email'] = email;
    data['name'] = name;
    data['role'] = role;
    data['phone'] = phone;
    data['hire_date'] = hireDate;
    data['email_verified_at'] = emailVerifiedAt;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['task_type'] = taskType;
    data['keterangan'] = keterangan;
    data['signature'] = signature;
    data['jabatan'] = jabatan;
    data['login_atk'] = loginAtk;
    data['login_izin'] = loginIzin;
    data['login_event'] = loginEvent;
    data['login_ca'] = loginCa;
    return data;
  }

  @override
  toString() => "id: $id, nik: $nik, username: $username, email: $email, name: $name, role: $role, phone: $phone, hireDate: $hireDate";
}
