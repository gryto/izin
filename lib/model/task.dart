

class Task {
  int? id;
  String? task;
  int? assignedBy;
  int? assignedTo;
  String? startDate;
  String? endDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  // User? user;

  Task(
      {this.id,
      this.task,
      this.assignedBy,
      this.assignedTo,
      this.startDate,
      this.endDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      // this.user
      });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task = json['task'];
    assignedBy = json['assigned_by'];
    assignedTo = json['assigned_to'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task'] = task;
    data['assigned_by'] = assignedBy;
    data['assigned_to'] = assignedTo;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    // if (user != null) {
    //   data['user'] = user!.toJson(user!);
    // }
    return data;
  }

  @override
  toString() =>
      "id: $id, task: $task, assignedBy: $assignedBy, assignedTo: $assignedTo, startDate: $startDate, endDate: $endDate, status: $status";
}
