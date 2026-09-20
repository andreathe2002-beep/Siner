import '../models/report_model.dart';

class ReportService {
  static final List<ReportModel> _reports = [];

  List<ReportModel> getAllReports() {
    final sorted = List<ReportModel>.from(_reports)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted;
  }

  List<ReportModel> getReportsForProject(String projectId) {
    return _reports.where((r) => r.projectId == projectId).toList();
  }

  void addReport(ReportModel report) {
    _reports.insert(0, report);
  }

  void deleteReport(String id) {
    _reports.removeWhere((r) => r.id == id);
  }

  int get totalReports => _reports.length;
}
