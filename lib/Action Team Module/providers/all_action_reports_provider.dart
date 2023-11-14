import 'package:flutter/material.dart';
import 'package:user_ims/User%20Module/services/ReportServices.dart';
import 'package:user_ims/models/action_report.dart';

class ActionReportsProvider with ChangeNotifier {
  List<ActionReport> _reports = [];
  List<ActionReport> get reports => _reports;
  bool isLoading = false;

  Future<void> fetchAllActionReports(BuildContext context) async {
    try {
      isLoading=true;
      _reports = await ReportServices(context).fetchAllActionReports();
      isLoading=false;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
