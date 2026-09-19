class EmployeeClientVisitListModel {
  bool? success;
  int? statusCode;
  String? message;
  VisitListData? data;
  Meta? meta;

  EmployeeClientVisitListModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
    this.meta,
  });

  EmployeeClientVisitListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? VisitListData.fromJson(json['data']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class VisitListData {
  List<TabItem>? tabs;
  VisitSummary? summary;
  VisitEmployee? employee;
  String? date;
  VisitFilters? filters;
  List<Visit>? visits;

  VisitListData({
    this.tabs,
    this.summary,
    this.employee,
    this.date,
    this.filters,
    this.visits,
  });

  VisitListData.fromJson(Map<String, dynamic> json) {
    if (json['tabs'] != null) {
      tabs = <TabItem>[];
      json['tabs'].forEach((v) {
        tabs!.add(TabItem.fromJson(v));
      });
    }
    summary = json['summary'] != null ? VisitSummary.fromJson(json['summary']) : null;
    employee = json['employee'] != null ? VisitEmployee.fromJson(json['employee']) : null;
    date = json['date'];
    filters = json['filters'] != null ? VisitFilters.fromJson(json['filters']) : null;
    if (json['visits'] != null) {
      visits = <Visit>[];
      json['visits'].forEach((v) {
        visits!.add(Visit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tabs != null) {
      data['tabs'] = tabs!.map((v) => v.toJson()).toList();
    }
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    data['date'] = date;
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    if (visits != null) {
      data['visits'] = visits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TabItem {
  String? key;
  String? label;
  int? count;
  String? title;
  bool? isActive;

  TabItem({this.key, this.label, this.count, this.title, this.isActive});

  TabItem.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    label = json['label'];
    count = json['count'];
    title = json['title'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['label'] = label;
    data['count'] = count;
    data['title'] = title;
    data['is_active'] = isActive;
    return data;
  }
}

class VisitSummary {
  int? total;
  int? upcoming;
  int? completed;
  int? inProgress;
  int? scheduled;
  int? postponed;
  int? cancelled;
  int? totalVisits;
  int? upcomingVisits;
  int? completedVisits;
  int? inProgressVisits;
  int? scheduledVisits;
  int? cancelledVisits;
  int? postponedVisits;

  VisitSummary({
    this.total,
    this.upcoming,
    this.completed,
    this.inProgress,
    this.scheduled,
    this.postponed,
    this.cancelled,
    this.totalVisits,
    this.upcomingVisits,
    this.completedVisits,
    this.inProgressVisits,
    this.scheduledVisits,
    this.cancelledVisits,
    this.postponedVisits,
  });

  VisitSummary.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    upcoming = json['upcoming'];
    completed = json['completed'];
    inProgress = json['in_progress'];
    scheduled = json['scheduled'];
    postponed = json['postponed'];
    cancelled = json['cancelled'];
    totalVisits = json['total_visits'];
    upcomingVisits = json['upcoming_visits'];
    completedVisits = json['completed_visits'];
    inProgressVisits = json['in_progress_visits'];
    scheduledVisits = json['scheduled_visits'];
    cancelledVisits = json['cancelled_visits'];
    postponedVisits = json['postponed_visits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['upcoming'] = upcoming;
    data['completed'] = completed;
    data['in_progress'] = inProgress;
    data['scheduled'] = scheduled;
    data['postponed'] = postponed;
    data['cancelled'] = cancelled;
    data['total_visits'] = totalVisits;
    data['upcoming_visits'] = upcomingVisits;
    data['completed_visits'] = completedVisits;
    data['in_progress_visits'] = inProgressVisits;
    data['scheduled_visits'] = scheduledVisits;
    data['cancelled_visits'] = cancelledVisits;
    data['postponed_visits'] = postponedVisits;
    return data;
  }
}

class VisitEmployee {
  String? id;
  String? employeeCode;
  String? name;
  String? firstName;
  String? lastName;
  String? designation;
  String? department;
  String? officialEmail;
  String? mobile;
  String? avatarUrl;

  VisitEmployee({
    this.id,
    this.employeeCode,
    this.name,
    this.firstName,
    this.lastName,
    this.designation,
    this.department,
    this.officialEmail,
    this.mobile,
    this.avatarUrl,
  });

  VisitEmployee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeCode = json['employee_code'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    designation = json['designation'];
    department = json['department'];
    officialEmail = json['official_email'];
    mobile = json['mobile'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_code'] = employeeCode;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['designation'] = designation;
    data['department'] = department;
    data['official_email'] = officialEmail;
    data['mobile'] = mobile;
    data['avatar_url'] = avatarUrl;
    return data;
  }
}

class VisitFilters {
  String? date;
  String? status;
  String? search;

  VisitFilters({this.date, this.status, this.search});

  VisitFilters.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['status'] = status;
    data['search'] = search;
    return data;
  }
}

class Visit {
  String? id;
  String? organizationId;
  String? employeeDetailsLabel;
  String? employeeName;
  String? employeeAvatar;
  String? employeeAvatarUrl;
  String? employeeCode;
  String? scheduleTimeLabel;
  String? scheduleTime;
  String? scheduledStartTime;
  String? scheduledEndTime;
  String? scheduledDate;
  String? scheduledStartAt;
  String? clientName;
  String? clientAddress;
  String? meetingAddress;
  double? meetingLatitude;
  double? meetingLongitude;
  String? status;
  String? statusLabel;
  StatusBadge? statusBadge;
  String? requirement;
  String? purpose;
  String? tag;
  String? clientId;
  VisitClient? client;
  String? assignedEmployeeId;
  VisitEmployee? assignedEmployee;
  String? scheduledByEmployeeId;
  ScheduledBy? scheduledBy;
  String? contactName;
  String? contactPhone;
  String? contactEmail;
  String? actualStartAt;
  String? actualEndAt;
  String? visitNote;
  int? documentsCount;
  List<dynamic>? documents;
  List<StatusHistory>? statusHistory;

  Visit({
    this.id,
    this.organizationId,
    this.employeeDetailsLabel,
    this.employeeName,
    this.employeeAvatar,
    this.employeeAvatarUrl,
    this.employeeCode,
    this.scheduleTimeLabel,
    this.scheduleTime,
    this.scheduledStartTime,
    this.scheduledEndTime,
    this.scheduledDate,
    this.scheduledStartAt,
    this.clientName,
    this.clientAddress,
    this.meetingAddress,
    this.meetingLatitude,
    this.meetingLongitude,
    this.status,
    this.statusLabel,
    this.statusBadge,
    this.requirement,
    this.purpose,
    this.tag,
    this.clientId,
    this.client,
    this.assignedEmployeeId,
    this.assignedEmployee,
    this.scheduledByEmployeeId,
    this.scheduledBy,
    this.contactName,
    this.contactPhone,
    this.contactEmail,
    this.actualStartAt,
    this.actualEndAt,
    this.visitNote,
    this.documentsCount,
    this.documents,
    this.statusHistory,
  });

  Visit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organization_id'];
    employeeDetailsLabel = json['employee_details_label'];
    employeeName = json['employee_name'];
    employeeAvatar = json['employee_avatar'];
    employeeAvatarUrl = json['employee_avatar_url'];
    employeeCode = json['employee_code'];
    scheduleTimeLabel = json['schedule_time_label'];
    scheduleTime = json['schedule_time'];
    scheduledStartTime = json['scheduled_start_time'];
    scheduledEndTime = json['scheduled_end_time'];
    scheduledDate = json['scheduled_date'];
    scheduledStartAt = json['scheduled_start_at'];
    clientName = json['client_name'];
    clientAddress = json['client_address'];
    meetingAddress = json['meeting_address'];
    meetingLatitude = json['meeting_latitude']?.toDouble();
    meetingLongitude = json['meeting_longitude']?.toDouble();
    status = json['status'];
    statusLabel = json['status_label'];
    statusBadge = json['status_badge'] != null ? StatusBadge.fromJson(json['status_badge']) : null;
    requirement = json['requirement'];
    purpose = json['purpose'];
    tag = json['tag'];
    clientId = json['client_id'];
    client = json['client'] != null ? VisitClient.fromJson(json['client']) : null;
    assignedEmployeeId = json['assigned_employee_id'];
    assignedEmployee = json['assigned_employee'] != null ? VisitEmployee.fromJson(json['assigned_employee']) : null;
    scheduledByEmployeeId = json['scheduled_by_employee_id'];
    scheduledBy = json['scheduled_by'] != null ? ScheduledBy.fromJson(json['scheduled_by']) : null;
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    contactEmail = json['contact_email'];
    actualStartAt = json['actual_start_at'];
    actualEndAt = json['actual_end_at'];
    visitNote = json['visit_note'];
    documentsCount = json['documents_count'];
    if (json['documents'] != null) {
      documents = json['documents'];
    }
    if (json['status_history'] != null) {
      statusHistory = <StatusHistory>[];
      json['status_history'].forEach((v) {
        statusHistory!.add(StatusHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['organization_id'] = organizationId;
    data['employee_details_label'] = employeeDetailsLabel;
    data['employee_name'] = employeeName;
    data['employee_avatar'] = employeeAvatar;
    data['employee_avatar_url'] = employeeAvatarUrl;
    data['employee_code'] = employeeCode;
    data['schedule_time_label'] = scheduleTimeLabel;
    data['schedule_time'] = scheduleTime;
    data['scheduled_start_time'] = scheduledStartTime;
    data['scheduled_end_time'] = scheduledEndTime;
    data['scheduled_date'] = scheduledDate;
    data['scheduled_start_at'] = scheduledStartAt;
    data['client_name'] = clientName;
    data['client_address'] = clientAddress;
    data['meeting_address'] = meetingAddress;
    data['meeting_latitude'] = meetingLatitude;
    data['meeting_longitude'] = meetingLongitude;
    data['status'] = status;
    data['status_label'] = statusLabel;
    if (statusBadge != null) {
      data['status_badge'] = statusBadge!.toJson();
    }
    data['requirement'] = requirement;
    data['purpose'] = purpose;
    data['tag'] = tag;
    data['client_id'] = clientId;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    data['assigned_employee_id'] = assignedEmployeeId;
    if (assignedEmployee != null) {
      data['assigned_employee'] = assignedEmployee!.toJson();
    }
    data['scheduled_by_employee_id'] = scheduledByEmployeeId;
    if (scheduledBy != null) {
      data['scheduled_by'] = scheduledBy!.toJson();
    }
    data['contact_name'] = contactName;
    data['contact_phone'] = contactPhone;
    data['contact_email'] = contactEmail;
    data['actual_start_at'] = actualStartAt;
    data['actual_end_at'] = actualEndAt;
    data['visit_note'] = visitNote;
    data['documents_count'] = documentsCount;
    if (documents != null) {
      data['documents'] = documents;
    }
    if (statusHistory != null) {
      data['status_history'] = statusHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusBadge {
  String? text;
  String? label;
  String? variant;
  String? color;
  String? textColor;
  String? bgColor;
  String? borderColor;

  StatusBadge({
    this.text,
    this.label,
    this.variant,
    this.color,
    this.textColor,
    this.bgColor,
    this.borderColor,
  });

  StatusBadge.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    label = json['label'];
    variant = json['variant'];
    color = json['color'];
    textColor = json['text_color'];
    bgColor = json['bg_color'];
    borderColor = json['border_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['label'] = label;
    data['variant'] = variant;
    data['color'] = color;
    data['text_color'] = textColor;
    data['bg_color'] = bgColor;
    data['border_color'] = borderColor;
    return data;
  }
}

class VisitClient {
  String? id;
  String? name;
  String? clientCode;
  String? address;
  double? latitude;
  double? longitude;
  String? status;

  VisitClient({
    this.id,
    this.name,
    this.clientCode,
    this.address,
    this.latitude,
    this.longitude,
    this.status,
  });

  VisitClient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    clientCode = json['client_code'];
    address = json['address'];
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['client_code'] = clientCode;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['status'] = status;
    return data;
  }
}

class ScheduledBy {
  String? id;
  String? employeeCode;
  String? name;
  String? designation;

  ScheduledBy({this.id, this.employeeCode, this.name, this.designation});

  ScheduledBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeCode = json['employee_code'];
    name = json['name'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_code'] = employeeCode;
    data['name'] = name;
    data['designation'] = designation;
    return data;
  }
}

class StatusHistory {
  String? id;
  String? fromStatus;
  String? toStatus;
  String? changedByName;
  String? changedAt;

  StatusHistory({
    this.id,
    this.fromStatus,
    this.toStatus,
    this.changedByName,
    this.changedAt,
  });

  StatusHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromStatus = json['from_status'];
    toStatus = json['to_status'];
    changedByName = json['changed_by_name'];
    changedAt = json['changed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_status'] = fromStatus;
    data['to_status'] = toStatus;
    data['changed_by_name'] = changedByName;
    data['changed_at'] = changedAt;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;

  Meta({this.currentPage, this.perPage, this.total, this.lastPage});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    total = json['total'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['per_page'] = perPage;
    data['total'] = total;
    data['last_page'] = lastPage;
    return data;
  }
}
