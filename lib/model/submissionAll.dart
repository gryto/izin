class SubmissionAll {
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

  SubmissionAll(
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

  SubmissionAll.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? role;
  String? taskType;

  Users({this.name, this.role, this.taskType});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    role = json['role'];
    taskType = json['task_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['role'] = this.role;
    data['task_type'] = this.taskType;
    return data;
  }
}