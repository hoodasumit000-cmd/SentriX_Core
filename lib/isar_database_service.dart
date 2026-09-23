import 'package:isar/isar.dart';
import 'package:flutter/foundation.dart';

class IsarDatabaseService {
  late Isar isar;

  // Isar DB इनिशियलाइज़ेशन (यदि पहले से है तो इसे बनाए रखें)
  Future<void> initDatabase() async {
    // Isar schemas init code...
  }

  /// 🚨 ANTI-FORENSIC PURGE: पूरे डेटाबेस के सभी टेबल्स को 0-बाइट पर रीसेट करना
  Future<void> clearAllVaultTables() async {
    try {
      if (isar.isOpen) {
        await isar.writeTxn(() async {
          // Isar के सभी कलेक्शन/टेबल्स को पूरी तरह खाली (Clear) करना
          await isar.clear();
        });
        debugPrint(" Isar Local Storage: All vault collections purged successfully.");
      } else {
        debugPrint(" Isar DB was not open during purge attempt.");
      }
    } catch (e) {
      debugPrint(" Error purging Isar database: $e");
    }
  }
}
