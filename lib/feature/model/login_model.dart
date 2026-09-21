class LoginModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final LoginData? data;

  LoginModel({this.success, this.statusCode, this.message, this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'],
      statusCode: json['status_code'],
      message: json['message'],
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  final String? token;
  final String? tokenType;
  final int? expiresIn;
  final User? user;

  LoginData({this.token, this.tokenType, this.expiresIn, this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final String? id;
  final String? employeeId;
  final String? username;
  final String? email;
  final String? status;
  final Employee? employee;

  User({
    this.id,
    this.employeeId,
    this.username,
    this.email,
    this.status,
    this.employee,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      employeeId: json['employee_id'],
      username: json['username'],
      email: json['email'],
      status: json['status'],
      employee: json['employee'] != null ? Employee.fromJson(json['employee']) : null,
    );
  }
}

class Employee {
  final String? id;
  final String? employeeCode;
  final String? firstName;
  final String? lastName;
  final String? officialEmail;
  final String? mobile;
  final String? name;
  final Department? department;
  final Designation? designation;

  Employee({
    this.id,
    this.employeeCode,
    this.firstName,
    this.lastName,
    this.officialEmail,
    this.mobile,
    this.name,
    this.department,
    this.designation,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      employeeCode: json['employee_code'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      officialEmail: json['official_email'],
      mobile: json['mobile'],
      name: json['name'],
      department: json['department'] != null ? Department.fromJson(json['department']) : null,
      designation: json['designation'] != null ? Designation.fromJson(json['designation']) : null,
    );
  }
}

class Department {
  final String? id;
  final String? code;
  final String? name;

  Department({this.id, this.code, this.name});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }
}

class Designation {
  final String? id;
  final String? code;
  final String? name;

  Designation({this.id, this.code, this.name});

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }
}
