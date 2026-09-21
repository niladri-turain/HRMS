import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/api_end_points.dart';
import 'package:hrms_app/core/service/api_service.dart';
import 'package:hrms_app/feature/model/employee_list_model.dart';

class EmployeeListProvider extends ChangeNotifier {
  final ApiService apiService;

  EmployeeListProvider({required this.apiService});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<EmployeeData> _employees = [];
  List<EmployeeData> get employees => _employees;

  Future<void> fetchEmployeeList() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiService.get(ApiEndPoints.employeeList);

      if (response.statusCode == 200) {
        final model = EmployeeListModel.fromJson(response.data);
        if (model.success == true) {
          _employees = model.data ?? [];
          if (_employees.isEmpty) {
            _errorMessage = model.message ?? 'No employee list found';
          }
        } else {
          _employees = [];
          _errorMessage = model.message ?? 'Failed to retrieve employees';
        }
      } else {
        _employees = [];
        _errorMessage = response.data['message'] ?? 'Failed to load employee list';
      }
    } catch (e) {
      _employees = [];
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
