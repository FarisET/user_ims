import 'package:flutter/material.dart';
import 'package:user_ims/User%20Module/services/ReportServices.dart';
import '../../models/report.dart';

class UserReportsProvider with ChangeNotifier {
  List<Reports> _reports = [];
  List<Reports> get reports => _reports;
  bool isLoading = false;

  Future<void> fetchReports(BuildContext context) async {
    try {
      isLoading=true;
      _reports = await ReportServices(context).fetchReports();
      isLoading=false;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
