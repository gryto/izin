class DashboardIzinAll {
  int? approveIzin;
  int? allIzin;
  int? failedIzin;
  // Group? group;

  DashboardIzinAll(
      {this.approveIzin, this.allIzin, this.failedIzin,});

  DashboardIzinAll.fromJson(Map<String, dynamic> json) {
    approveIzin = json['approve_izin'];
    allIzin = json['all_izin'];
    failedIzin = json['failed_izin'];
    // group = json['group'] != null ? new Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approve_izin'] = this.approveIzin;
    data['all_izin'] = this.allIzin;
    data['failed_izin'] = this.failedIzin;
    // if (this.group != null) {
    //   data['group'] = this.group!.toJson();
    // }
    return data;
  }

   @override
  toString() => "approveIzin: $approveIzin, allIzin: $allIzin, failedIzin: $failedIzin";
}



// class Group {
//   List<TugasLuarKantor>? tugasLuarKantor;
//   List<Sakit>? sakit;

//   Group({this.tugasLuarKantor, this.sakit});

//   Group.fromJson(Map<String, dynamic> json) {
//     if (json['Tugas luar kantor'] != null) {
//       tugasLuarKantor = <TugasLuarKantor>[];
//       json['Tugas luar kantor'].forEach((v) {
//         tugasLuarKantor!.add(new TugasLuarKantor.fromJson(v));
//       });
//     }
//     if (json['Sakit'] != null) {
//       sakit = <Sakit>[];
//       json['Sakit'].forEach((v) {
//         sakit!.add(new Sakit.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.tugasLuarKantor != null) {
//       data['Tugas luar kantor'] =
//           this.tugasLuarKantor!.map((v) => v.toJson()).toList();
//     }
//     if (this.sakit != null) {
//       data['Sakit'] = this.sakit!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class TugasLuarKantor {
//   int? id;
//   int? employeeId;
//   int? superadminId;
//   int? adminId;
//   String? reason;
//   String? description;
//   String? startDate;
//   String? endDate;
//   String? startTime;
//   String? endTime;
//   String? status;
//   String? statusAdmin;
//   String? statusSuperadmin;
//   int? readByAdmin;
//   int? readBySuperadmin;
//   String? checkedByAdmin;
//   String? checkedBySuperadmin;
//   String? createdAt;
//   String? updatedAt;
//   String? superadminUsername;
//   String? adminUsername;
//   String? username;
//   String? name;

//   TugasLuarKantor(
//       {this.id,
//       this.employeeId,
//       this.superadminId,
//       this.adminId,
//       this.reason,
//       this.description,
//       this.startDate,
//       this.endDate,
//       this.startTime,
//       this.endTime,
//       this.status,
//       this.statusAdmin,
//       this.statusSuperadmin,
//       this.readByAdmin,
//       this.readBySuperadmin,
//       this.checkedByAdmin,
//       this.checkedBySuperadmin,
//       this.createdAt,
//       this.updatedAt,
//       this.superadminUsername,
//       this.adminUsername,
//       this.username,
//       this.name});

//   TugasLuarKantor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     employeeId = json['employee_id'];
//     superadminId = json['superadmin_id'];
//     adminId = json['admin_id'];
//     reason = json['reason'];
//     description = json['description'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     startTime = json['start_time'];
//     endTime = json['end_time'];
//     status = json['status'];
//     statusAdmin = json['status_admin'];
//     statusSuperadmin = json['status_superadmin'];
//     readByAdmin = json['read_by_admin'];
//     readBySuperadmin = json['read_by_superadmin'];
//     checkedByAdmin = json['checked_by_admin'];
//     checkedBySuperadmin = json['checked_by_superadmin'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     superadminUsername = json['superadmin_username'];
//     adminUsername = json['admin_username'];
//     username = json['username'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['employee_id'] = this.employeeId;
//     data['superadmin_id'] = this.superadminId;
//     data['admin_id'] = this.adminId;
//     data['reason'] = this.reason;
//     data['description'] = this.description;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['start_time'] = this.startTime;
//     data['end_time'] = this.endTime;
//     data['status'] = this.status;
//     data['status_admin'] = this.statusAdmin;
//     data['status_superadmin'] = this.statusSuperadmin;
//     data['read_by_admin'] = this.readByAdmin;
//     data['read_by_superadmin'] = this.readBySuperadmin;
//     data['checked_by_admin'] = this.checkedByAdmin;
//     data['checked_by_superadmin'] = this.checkedBySuperadmin;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['superadmin_username'] = this.superadminUsername;
//     data['admin_username'] = this.adminUsername;
//     data['username'] = this.username;
//     data['name'] = this.name;
//     return data;
//   }
// }

// class Sakit {
//   int? id;
//   int? employeeId;
//   int? superadminId;
//   int? adminId;
//   String? reason;
//   String? description;
//   String? startDate;
//   String? endDate;
//   String? startTime;
//   String? endTime;
//   String? status;
//   String? statusAdmin;
//   String? statusSuperadmin;
//   int? readByAdmin;
//   int? readBySuperadmin;
//   String? checkedByAdmin;
//   String? checkedBySuperadmin;
//   String? createdAt;
//   String? updatedAt;
//   String? superadminUsername;
//   String? adminUsername;
//   String? username;
//   String? name;

//   Sakit(
//       {this.id,
//       this.employeeId,
//       this.superadminId,
//       this.adminId,
//       this.reason,
//       this.description,
//       this.startDate,
//       this.endDate,
//       this.startTime,
//       this.endTime,
//       this.status,
//       this.statusAdmin,
//       this.statusSuperadmin,
//       this.readByAdmin,
//       this.readBySuperadmin,
//       this.checkedByAdmin,
//       this.checkedBySuperadmin,
//       this.createdAt,
//       this.updatedAt,
//       this.superadminUsername,
//       this.adminUsername,
//       this.username,
//       this.name});

//   Sakit.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     employeeId = json['employee_id'];
//     superadminId = json['superadmin_id'];
//     adminId = json['admin_id'];
//     reason = json['reason'];
//     description = json['description'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     startTime = json['start_time'];
//     endTime = json['end_time'];
//     status = json['status'];
//     statusAdmin = json['status_admin'];
//     statusSuperadmin = json['status_superadmin'];
//     readByAdmin = json['read_by_admin'];
//     readBySuperadmin = json['read_by_superadmin'];
//     checkedByAdmin = json['checked_by_admin'];
//     checkedBySuperadmin = json['checked_by_superadmin'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     superadminUsername = json['superadmin_username'];
//     adminUsername = json['admin_username'];
//     username = json['username'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['employee_id'] = this.employeeId;
//     data['superadmin_id'] = this.superadminId;
//     data['admin_id'] = this.adminId;
//     data['reason'] = this.reason;
//     data['description'] = this.description;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['start_time'] = this.startTime;
//     data['end_time'] = this.endTime;
//     data['status'] = this.status;
//     data['status_admin'] = this.statusAdmin;
//     data['status_superadmin'] = this.statusSuperadmin;
//     data['read_by_admin'] = this.readByAdmin;
//     data['read_by_superadmin'] = this.readBySuperadmin;
//     data['checked_by_admin'] = this.checkedByAdmin;
//     data['checked_by_superadmin'] = this.checkedBySuperadmin;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['superadmin_username'] = this.superadminUsername;
//     data['admin_username'] = this.adminUsername;
//     data['username'] = this.username;
//     data['name'] = this.name;
//     return data;
//   }
// }