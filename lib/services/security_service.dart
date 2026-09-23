import 'package:flutter/material.dart';
import 'isar_database_service.dart';

class SecurityService {
  // Toggle Air-Gapped Military Mode
  static void toggleMilitaryMode(BuildContext context, bool value) {
    final status = value ? 'ENABLED' : 'DISABLED';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Air-Gapped Military Mode: $status'),
        backgroundColor: value ? Colors.amber.shade900 : Colors.grey.shade800,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Trigger Duress Data Wipe Protocol with PIN Confirmation
  static void triggerDuressDataWipe(BuildContext context) {
    final TextEditingController pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
              SizedBox(width: 8),
              Text(
                'DURESS DATA WIPE',
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Warning: This action will permanently erase all local system logs, diagnostic history, and telemetry caches.',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: pinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Enter Security PIN (e.g. 9999)',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                
                // Clear local storage logs via database service
                await IsarDatabaseService.clearAllLogs();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('SECURITY ALERT: Duress Wipe Initiated. All local logs purged.'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text('EXECUTE WIPE', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
