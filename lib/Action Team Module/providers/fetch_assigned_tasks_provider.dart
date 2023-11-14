import 'package:flutter/material.dart';
import 'package:user_ims/User%20Module/services/ReportServices.dart';
import 'package:user_ims/models/assign_task.dart';

class AssignedTaskProvider with ChangeNotifier {
  List<AssignTask> _tasks = [];
  List<AssignTask> get tasks => _tasks;
  bool isLoading = false;

  Future<void> fetchAssignedTasks(BuildContext context) async {
    try {
      isLoading=true;
      _tasks = await ReportServices(context).fetchAssignedReports();
      isLoading=false;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
