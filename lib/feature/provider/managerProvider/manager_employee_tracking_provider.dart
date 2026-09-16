import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/api_end_points.dart';
import 'package:hrms_app/core/service/api_service.dart';
import 'package:hrms_app/feature/model/managerModel/employee_tracking_model.dart';

class ManagerEmployeeTrackingProvider extends ChangeNotifier {
  final ApiService apiService;

  ManagerEmployeeTrackingProvider({required this.apiService});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  EmployeeTrackingModel? _trackingData;
  EmployeeTrackingModel? get trackingData => _trackingData;

  Future<void> fetchEmployeeJourney(String employeeId, String dateStr) async {
    _isLoading = true;
    _errorMessage = null;
    _trackingData = null;
    notifyListeners();

    try {
      final response = await apiService.get(
        ApiEndPoints.employeeJourney(employeeId),
        queryParameters: {'data': dateStr},
      );

      if (response.statusCode == 200) {
        final model = EmployeeTrackingModel.fromJson(response.data);
        if (model.success == true) {
          _trackingData = model;
        } else {
          _errorMessage = model.message ?? 'Failed to retrieve employee journey';
        }
      } else {
        _errorMessage = response.data['message'] ?? 'Failed to load employee journey';
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
