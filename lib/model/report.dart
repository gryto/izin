class Report {
  int? id;
  int? employeeId;
  int? superadminId;
  int? adminId;
  String? reason;
  String? description;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? status;
  String? statusAdmin;
  String? statusSuperadmin;
  int? readByAdmin;
  int? readBySuperadmin;
  String? checkedByAdmin;
  String? checkedBySuperadmin;
  String? createdAt;
  String? updatedAt;
  String? superadminUsername;
  String? adminUsername;
  String? username;
  Users? users;

  Report(
      {this.id,
      this.employeeId,
      this.superadminId,
      this.adminId,
      this.reason,
      this.description,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.status,
      this.statusAdmin,
      this.statusSuperadmin,
      this.readByAdmin,
      this.readBySuperadmin,
      this.checkedByAdmin,
      this.checkedBySuperadmin,
      this.createdAt,
      this.updatedAt,
      this.superadminUsername,
      this.adminUsername,
      this.username,
      this.users});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    superadminId = json['superadmin_id'];
    adminId = json['admin_id'];
    reason = json['reason'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    statusAdmin = json['status_admin'];
    statusSuperadmin = json['status_superadmin'];
    readByAdmin = json['read_by_admin'];
    readBySuperadmin = json['read_by_superadmin'];
    checkedByAdmin = json['checked_by_admin'];
    checkedBySuperadmin = json['checked_by_superadmin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    superadminUsername = json['superadmin_username'];
    adminUsername = json['admin_username'];
    username = json['username'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['superadmin_id'] = this.superadminId;
    data['admin_id'] = this.adminId;
    data['reason'] = this.reason;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    data['status_admin'] = this.statusAdmin;
    data['status_superadmin'] = this.statusSuperadmin;
    data['read_by_admin'] = this.readByAdmin;
    data['read_by_superadmin'] = this.readBySuperadmin;
    data['checked_by_admin'] = this.checkedByAdmin;
    data['checked_by_superadmin'] = this.checkedBySuperadmin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['superadmin_username'] = this.superadminUsername;
    data['admin_username'] = this.adminUsername;
    data['username'] = this.username;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}

class Users {
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

  Users(
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

  Users.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nik'] = this.nik;
    data['username'] = this.username;
    data['email'] = this.email;
    data['name'] = this.name;
    data['role'] = this.role;
    data['phone'] = this.phone;
    data['hire_date'] = this.hireDate;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['task_type'] = this.taskType;
    data['keterangan'] = this.keterangan;
    data['signature'] = this.signature;
    data['jabatan'] = this.jabatan;
    data['login_atk'] = this.loginAtk;
    data['login_izin'] = this.loginIzin;
    data['login_event'] = this.loginEvent;
    data['login_ca'] = this.loginCa;
    return data;
  }
}