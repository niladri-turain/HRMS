class ManagerClientVisitListModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;
  Meta? meta;

  ManagerClientVisitListModel({this.success, this.statusCode, this.message, this.data, this.meta});

  ManagerClientVisitListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class Data {
  List<VisitTab>? tabs;
  Summary? summary;
  Manager? manager;
  Filters? filters;
  List<Visit>? visits;

  Data({this.tabs, this.summary, this.manager, this.filters, this.visits});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['tabs'] != null) {
      tabs = <VisitTab>[];
      json['tabs'].forEach((v) {
        tabs!.add(VisitTab.fromJson(v));
      });
    }
    summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    manager = json['manager'] != null ? Manager.fromJson(json['manager']) : null;
    filters = json['filters'] != null ? Filters.fromJson(json['filters']) : null;
    if (json['visits'] != null) {
      visits = <Visit>[];
      json['visits'].forEach((v) {
        visits!.add(Visit.fromJson(v));
      });
    }
  }
}

class VisitTab {
  String? key;
  String? label;
  int? count;
  String? title;
  bool? isActive;

  VisitTab({this.key, this.label, this.count, this.title, this.isActive});

  VisitTab.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    label = json['label'];
    count = json['count'];
    title = json['title'];
    isActive = json['is_active'];
  }
}

class Summary {
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
  int? scheduledVisits;
  int? inProgressVisits;
  int? cancelledVisits;
  int? postponedVisits;
  int? totalAssignedEmployees;

  Summary(
      {this.total,
      this.upcoming,
      this.completed,
      this.inProgress,
      this.scheduled,
      this.postponed,
      this.cancelled,
      this.totalVisits,
      this.upcomingVisits,
      this.completedVisits,
      this.scheduledVisits,
      this.inProgressVisits,
      this.cancelledVisits,
      this.postponedVisits,
      this.totalAssignedEmployees});

  Summary.fromJson(Map<String, dynamic> json) {
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
    scheduledVisits = json['scheduled_visits'];
    inProgressVisits = json['in_progress_visits'];
    cancelledVisits = json['cancelled_visits'];
    postponedVisits = json['postponed_visits'];
    totalAssignedEmployees = json['total_assigned_employees'];
  }
}

class Manager {
  String? id;
  String? employeeCode;
  String? name;
  String? firstName;
  String? lastName;
  String? designation;
  String? department;
  String? officialEmail;
  String? avatarUrl;

  Manager(
      {this.id,
      this.employeeCode,
      this.name,
      this.firstName,
      this.lastName,
      this.designation,
      this.department,
      this.officialEmail,
      this.avatarUrl});

  Manager.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeCode = json['employee_code'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    designation = json['designation'];
    department = json['department'];
    officialEmail = json['official_email'];
    avatarUrl = json['avatar_url'];
  }
}

class Filters {
  String? date;
  String? status;
  String? employeeId;
  String? search;

  Filters({this.date, this.status, this.employeeId, this.search});

  Filters.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
    employeeId = json['employee_id'];
    search = json['search'];
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
  Client? client;
  String? assignedEmployeeId;
  AssignedEmployee? assignedEmployee;
  String? scheduledByEmployeeId;
  ScheduledBy? scheduledBy;
  String? contactName;
  String? contactPhone;
  String? contactEmail;
  String? actualStartAt;
  String? actualEndAt;
  String? visitNote;
  int? documentsCount;
  List<Document>? documents;
  List<StatusHistory>? statusHistory;

  Visit(
      {this.id,
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
      this.statusHistory});

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
    statusBadge = json['status_badge'] != null
        ? StatusBadge.fromJson(json['status_badge'])
        : null;
    requirement = json['requirement'];
    purpose = json['purpose'];
    tag = json['tag'];
    clientId = json['client_id'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    assignedEmployeeId = json['assigned_employee_id'];
    assignedEmployee = json['assigned_employee'] != null
        ? AssignedEmployee.fromJson(json['assigned_employee'])
        : null;
    scheduledByEmployeeId = json['scheduled_by_employee_id'];
    scheduledBy = json['scheduled_by'] != null
        ? ScheduledBy.fromJson(json['scheduled_by'])
        : null;
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    contactEmail = json['contact_email'];
    actualStartAt = json['actual_start_at'];
    actualEndAt = json['actual_end_at'];
    visitNote = json['visit_note'];
    documentsCount = json['documents_count'];
    if (json['documents'] != null) {
      documents = <Document>[];
      json['documents'].forEach((v) {
        documents!.add(Document.fromJson(v));
      });
    }
    if (json['status_history'] != null) {
      statusHistory = <StatusHistory>[];
      json['status_history'].forEach((v) {
        statusHistory!.add(StatusHistory.fromJson(v));
      });
    }
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

  StatusBadge(
      {this.text,
      this.label,
      this.variant,
      this.color,
      this.textColor,
      this.bgColor,
      this.borderColor});

  StatusBadge.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    label = json['label'];
    variant = json['variant'];
    color = json['color'];
    textColor = json['text_color'];
    bgColor = json['bg_color'];
    borderColor = json['border_color'];
  }
}

class Client {
  String? id;
  String? name;
  String? clientCode;
  String? address;
  double? latitude;
  double? longitude;
  String? status;

  Client(
      {this.id,
      this.name,
      this.clientCode,
      this.address,
      this.latitude,
      this.longitude,
      this.status});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    clientCode = json['client_code'];
    address = json['address'];
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    status = json['status'];
  }
}

class AssignedEmployee {
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

  AssignedEmployee(
      {this.id,
      this.employeeCode,
      this.name,
      this.firstName,
      this.lastName,
      this.designation,
      this.department,
      this.officialEmail,
      this.mobile,
      this.avatarUrl});

  AssignedEmployee.fromJson(Map<String, dynamic> json) {
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
}

class Document {
  String? id;
  String? documentType;
  String? originalFileName;
  String? fileUrl;
  int? fileSizeBytes;

  Document(
      {this.id,
      this.documentType,
      this.originalFileName,
      this.fileUrl,
      this.fileSizeBytes});

  Document.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentType = json['document_type'];
    originalFileName = json['original_file_name'];
    fileUrl = json['file_url'];
    fileSizeBytes = json['file_size_bytes'];
  }
}

class StatusHistory {
  String? id;
  String? fromStatus;
  String? toStatus;
  String? changedByName;
  String? changedAt;

  StatusHistory(
      {this.id,
      this.fromStatus,
      this.toStatus,
      this.changedByName,
      this.changedAt});

  StatusHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromStatus = json['from_status'];
    toStatus = json['to_status'];
    changedByName = json['changed_by_name'];
    changedAt = json['changed_at'];
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
}
