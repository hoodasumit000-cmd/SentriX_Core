import 'package:flutter/material.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aura Sumit | Operational Hub'),
        backgroundColor: const Color(0xFF1F1F1F),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🛡️ Cascade Soft-Lock Banner
            Container(
              color: Colors.orange[800],
              padding: const EdgeInsets.all(12),
              child: const Text(
                "Organization Plan Pending Renewal. Running in Basic Safe Mode",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),

            // 📊 Live OBD-II / CAN-Bus Telemetry Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                color: const Color(0xFF1E1E1E),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.speed, color: Colors.green, size: 24),
                          SizedBox(width: 10),
                          Text(
                            "Live OBD-II / CAN-Bus Telemetry",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Engine RPM: 2450 RPM | Coolant Temp: 88.5°C",
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                        onPressed: () {
                          debugPrint("Generating Executive PDF Report...");
                        },
                        child: const Text("Generate Executive PDF Report"),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 🛠️ Manual Machine Diagnostics
            const ListTile(
              leading: Icon(Icons.build, color: Colors.green),
              title: Text("Manual Machine Diagnostics", style: TextStyle(color: Colors.white)),
              subtitle: Text("Basic Safe Mode Tool (Always Free)", style: TextStyle(color: Colors.white70)),
            ),

            // 🤖 AI Technical Co-Pilot (Locked)
            const ListTile(
              leading: Icon(Icons.lock, color: Colors.grey),
              title: Text("AI Technical Co-Pilot", style: TextStyle(color: Colors.grey)),
              subtitle: Text("Locked (Requires Master Plan)", style: TextStyle(color: Colors.grey)),
            ),

            // 📄 AI PDF Report Builder (Locked)
            const ListTile(
              leading: Icon(Icons.lock, color: Colors.grey),
              title: Text("AI PDF Report Builder", style: TextStyle(color: Colors.grey)),
              subtitle: Text("Locked (Requires Master Plan)", style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
