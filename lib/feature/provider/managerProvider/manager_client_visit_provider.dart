import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/api_end_points.dart';
import 'package:hrms_app/core/service/api_service.dart';
import 'package:hrms_app/feature/model/managerModel/manager_client_visit_list_model.dart';

class ManagerClientVisitProvider extends ChangeNotifier {
  final ApiService apiService;

  ManagerClientVisitProvider({required this.apiService});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ManagerClientVisitListModel? _visitListModel;
  ManagerClientVisitListModel? get visitListModel => _visitListModel;

  Future<void> fetchManagerClientVisits({
    String? date,
    String? status,
    String? employeeId,
    String? search,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final Map<String, dynamic> queryParams = {};
      if (date != null) queryParams['date'] = date;
      if (status != null) queryParams['status'] = status;
      if (employeeId != null) queryParams['employee_id'] = employeeId;
      if (search != null) queryParams['search'] = search;

      final response = await apiService.get(
        ApiEndPoints.managerClientVisitList,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        _visitListModel = ManagerClientVisitListModel.fromJson(response.data);
      } else {
        _errorMessage = response.data['message'] ?? 'Failed to fetch manager client visits';
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
