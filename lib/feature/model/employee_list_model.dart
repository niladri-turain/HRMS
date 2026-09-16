class EmployeeListModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final List<EmployeeData>? data;

  EmployeeListModel({this.success, this.statusCode, this.message, this.data});

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) {
    return EmployeeListModel(
      success: json['success'],
      statusCode: json['status_code'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((v) => EmployeeData.fromJson(v)).toList()
          : null,
    );
  }
}

class EmployeeData {
  final String? id;
  final String? name;
  final String? avatarUrl;
  final String? status;
  final String? lastLocation;
  final String? lastSeen;
  final ViewOnMap? viewOnMap;

  EmployeeData({
    this.id,
    this.name,
    this.avatarUrl,
    this.status,
    this.lastLocation,
    this.lastSeen,
    this.viewOnMap,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatar_url'],
      status: json['status'],
      lastLocation: json['last_location'],
      lastSeen: json['last_seen'],
      viewOnMap: json['view_on_map'] != null
          ? ViewOnMap.fromJson(json['view_on_map'])
          : null,
    );
  }
}

class ViewOnMap {
  final double? latitude;
  final double? longitude;
  final String? mapUrl;
  final String? journeyUrl;

  ViewOnMap({this.latitude, this.longitude, this.mapUrl, this.journeyUrl});

  factory ViewOnMap.fromJson(Map<String, dynamic> json) {
    return ViewOnMap(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      mapUrl: json['map_url'],
      journeyUrl: json['journey_url'],
    );
  }
}
