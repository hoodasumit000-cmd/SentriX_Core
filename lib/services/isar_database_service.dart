import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class IsarDatabaseService {
  static const String _logKey = 'sentrix_system_logs';

  // Save a new log entry
  static Future<void> addLog(String title, String details) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> logs = prefs.getStringList(_logKey) ?? [];

    final logEntry = {
      'title': title,
      'details': details,
      'timestamp': DateTime.now().toIso8601String(),
    };

    logs.add(jsonEncode(logEntry));
    await prefs.setStringList(_logKey, logs);
  }

  // Retrieve all saved logs
  static Future<List<Map<String, dynamic>>> getAllLogs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> logs = prefs.getStringList(_logKey) ?? [];

    return logs.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
  }

  // Clear all logs (for Duress Wipe protocol)
  static Future<void> clearAllLogs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_logKey);
  }
}
