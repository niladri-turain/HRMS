class EmployeeTrackingModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final JourneyData? data;

  EmployeeTrackingModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory EmployeeTrackingModel.fromJson(Map<String, dynamic> json) {
    return EmployeeTrackingModel(
      success: json['success'],
      statusCode: json['status_code'],
      message: json['message'],
      data: json['data'] != null ? JourneyData.fromJson(json['data']) : null,
    );
  }
}

class JourneyData {
  final String? date;
  final EmployeeInfo? employee;
  final AttendanceInfo? attendance;
  final JourneySummary? journeySummary;
  final SessionInfo? session;
  final List<StoppageInfo>? stoppages;
  final List<RouteCoordinate>? routeCoordinates;

  JourneyData({
    this.date,
    this.employee,
    this.attendance,
    this.journeySummary,
    this.session,
    this.stoppages,
    this.routeCoordinates,
  });

  factory JourneyData.fromJson(Map<String, dynamic> json) {
    return JourneyData(
      date: json['date'],
      employee: json['employee'] != null ? EmployeeInfo.fromJson(json['employee']) : null,
      attendance: json['attendance'] != null ? AttendanceInfo.fromJson(json['attendance']) : null,
      journeySummary: json['journey_summary'] != null ? JourneySummary.fromJson(json['journey_summary']) : null,
      session: json['session'] != null ? SessionInfo.fromJson(json['session']) : null,
      stoppages: json['stoppages'] != null
          ? (json['stoppages'] as List).map((i) => StoppageInfo.fromJson(i)).toList()
          : null,
      routeCoordinates: json['route_coordinates'] != null
          ? (json['route_coordinates'] as List).map((i) => RouteCoordinate.fromJson(i)).toList()
          : null,
    );
  }
}

class EmployeeInfo {
  final String? id;
  final String? employeeCode;
  final String? firstName;
  final String? lastName;
  final String? name;
  final String? officialEmail;
  final String? mobile;
  final String? employmentType;
  final String? employmentStatus;
  final DepartmentInfo? department;
  final DesignationInfo? designation;

  EmployeeInfo({
    this.id,
    this.employeeCode,
    this.firstName,
    this.lastName,
    this.name,
    this.officialEmail,
    this.mobile,
    this.employmentType,
    this.employmentStatus,
    this.department,
    this.designation,
  });

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) {
    return EmployeeInfo(
      id: json['id'],
      employeeCode: json['employee_code'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      name: json['name'],
      officialEmail: json['official_email'],
      mobile: json['mobile'],
      employmentType: json['employment_type'],
      employmentStatus: json['employment_status'],
      department: json['department'] != null ? DepartmentInfo.fromJson(json['department']) : null,
      designation: json['designation'] != null ? DesignationInfo.fromJson(json['designation']) : null,
    );
  }
}

class DepartmentInfo {
  final String? id;
  final String? code;
  final String? name;

  DepartmentInfo({this.id, this.code, this.name});

  factory DepartmentInfo.fromJson(Map<String, dynamic> json) {
    return DepartmentInfo(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }
}

class DesignationInfo {
  final String? id;
  final String? code;
  final String? name;

  DesignationInfo({this.id, this.code, this.name});

  factory DesignationInfo.fromJson(Map<String, dynamic> json) {
    return DesignationInfo(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }
}

class AttendanceInfo {
  final String? status;
  final bool? isPresent;
  final bool? isLoggedIn;
  final String? attendanceDate;
  final String? attendanceState;
  final String? loginAt;
  final String? logoutAt;
  final double? loginLatitude;
  final double? loginLongitude;
  final String? loginLocationName;

  AttendanceInfo({
    this.status,
    this.isPresent,
    this.isLoggedIn,
    this.attendanceDate,
    this.attendanceState,
    this.loginAt,
    this.logoutAt,
    this.loginLatitude,
    this.loginLongitude,
    this.loginLocationName,
  });

  factory AttendanceInfo.fromJson(Map<String, dynamic> json) {
    return AttendanceInfo(
      status: json['status'],
      isPresent: json['is_present'],
      isLoggedIn: json['is_logged_in'],
      attendanceDate: json['attendance_date'],
      attendanceState: json['attendance_state'],
      loginAt: json['login_at'],
      logoutAt: json['logout_at'],
      loginLatitude: (json['login_latitude'] as num?)?.toDouble(),
      loginLongitude: (json['login_longitude'] as num?)?.toDouble(),
      loginLocationName: json['login_location_name'],
    );
  }
}

class JourneySummary {
  final String? origin;
  final String? destination;
  final String? durationFormatted;
  final double? totalDistanceKm;
  final int? totalStoppages;
  final String? trackingStatus;

  JourneySummary({
    this.origin,
    this.destination,
    this.durationFormatted,
    this.totalDistanceKm,
    this.totalStoppages,
    this.trackingStatus,
  });

  factory JourneySummary.fromJson(Map<String, dynamic> json) {
    return JourneySummary(
      origin: json['origin'],
      destination: json['destination'],
      durationFormatted: json['duration_formatted'],
      totalDistanceKm: (json['total_distance_km'] as num?)?.toDouble(),
      totalStoppages: json['total_stoppages'],
      trackingStatus: json['tracking_status'],
    );
  }
}

class SessionInfo {
  final String? id;
  final String? status;
  final double? totalDistanceKm;

  SessionInfo({this.id, this.status, this.totalDistanceKm});

  factory SessionInfo.fromJson(Map<String, dynamic> json) {
    return SessionInfo(
      id: json['id'],
      status: json['status'],
      totalDistanceKm: (json['total_distance_km'] as num?)?.toDouble(),
    );
  }
}

class StoppageInfo {
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final String? arrivedAt;
  final String? departedAt;
  final int? durationMinutes;

  StoppageInfo({
    this.latitude,
    this.longitude,
    this.locationName,
    this.arrivedAt,
    this.departedAt,
    this.durationMinutes,
  });

  factory StoppageInfo.fromJson(Map<String, dynamic> json) {
    return StoppageInfo(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      locationName: json['location_name'],
      arrivedAt: json['arrived_at'],
      departedAt: json['departed_at'],
      durationMinutes: json['duration_minutes'],
    );
  }
}

class RouteCoordinate {
  final String? id;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final double? speed;
  final String? capturedAt;

  RouteCoordinate({
    this.id,
    this.latitude,
    this.longitude,
    this.locationName,
    this.speed,
    this.capturedAt,
  });

  factory RouteCoordinate.fromJson(Map<String, dynamic> json) {
    return RouteCoordinate(
      id: json['id'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      locationName: json['location_name'],
      speed: (json['speed'] as num?)?.toDouble(),
      capturedAt: json['captured_at'],
    );
  }
}
