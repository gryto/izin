class DashboardAtkRequest {
  int? total;
  int? pending;
  int? approved;
  int? rejected;
  int? done;

  DashboardAtkRequest({this.total, this.pending, this.approved, this.rejected, this.done});

  DashboardAtkRequest.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pending = json['pending'];
    approved = json['approved'];
    rejected = json['rejected'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['pending'] = this.pending;
    data['approved'] = this.approved;
    data['rejected'] = this.rejected;
    data['done'] = this.done;
    return data;
  }

  @override
  toString() => "pending: $pending, approved: $approved, rejected: $rejected";
}
