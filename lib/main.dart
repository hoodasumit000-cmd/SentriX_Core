import 'package:flutter/material.dart';
import 'screens/ai_copilot_screen.dart';
import 'pdf_service.dart';
import 'services/security_service.dart';

void main() {
  runApp(const SentriXCoreApp());
}

class SentriXCoreApp extends StatelessWidget {
  const SentriXCoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SentriX Core | Operational Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF00ADB5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isMasterPlanActive = false;
  bool isMilitaryModeActive = false;
  
  int engineRpm = 2450;
  double coolantTemp = 88.5;

  void toggleSubscription() {
    setState(() {
      isMasterPlanActive = !isMasterPlanActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SentriX Core | Operational Hub',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isMasterPlanActive ? Icons.verified_user : Icons.no_accounts,
              color: isMasterPlanActive ? Colors.green : Colors.orange,
            ),
            tooltip: 'Toggle Subscription (Demo)',
            onPressed: toggleSubscription,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              color: isMasterPlanActive ? Colors.green.shade800 : Colors.orange.shade900,
              child: Text(
                isMasterPlanActive
                    ? 'Organization Plan Active: All Master Features Unlocked'
                    : 'Organization Plan Pending Renewal. Running in Basic Safe Mode',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            _buildSectionCard(
              title: 'Live OBD-II / CAN-Bus Telemetry',
              icon: Icons.settings_remote,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Engine RPM: $engineRpm RPM  |  Coolant Temp: ${coolantTemp}°C',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      PdfReportService.generateExecutiveReport(
                        rpm: engineRpm,
                        coolantTemp: coolantTemp,
                        isMasterActive: isMasterPlanActive,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade700,
                    ),
                    child: const Text('Generate Executive PDF Report'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            _buildFeatureTile(
              title: 'Manual Machine Diagnostics',
              subtitle: 'Basic Safe Mode Tool (Always Free)',
              icon: Icons.build,
              isLocked: false,
              onTap: () {},
            ),
            const SizedBox(height: 10),

            _buildFeatureTile(
              title: 'AI Technical Co-Pilot',
              subtitle: isMasterPlanActive
                  ? 'Active Engine Diagnostic Assistant'
                  : 'Locked (Requires Master Plan)',
              icon: Icons.psychology,
              isLocked: !isMasterPlanActive,
              onTap: isMasterPlanActive ? () {} : null,
            ),
            const SizedBox(height: 10),

            _buildFeatureTile(
              title: 'AI PDF Report Builder',
              subtitle: isMasterPlanActive
                  ? 'Automated Insights & Security Logs'
                  : 'Locked (Requires Master Plan)',
              icon: Icons.picture_as_pdf,
              isLocked: !isMasterPlanActive,
              onTap: isMasterPlanActive ? () {} : null,
            ),
            const SizedBox(height: 15),

            // Security Controls
            Card(
              color: const Color(0xFF1E1E1E),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Security Vault & Defense Protocol',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.redAccent),
                    ),
                    const Divider(color: Colors.grey),
                    SwitchListTile(
                      title: const Text('Air-Gapped Military Mode'),
                      subtitle: const Text('Isolate system & block stealth background signals'),
                      value: isMilitaryModeActive,
                      activeColor: Colors.amber,
                      onChanged: (bool value) {
                        setState(() {
                          isMilitaryModeActive = value;
                        });
                        SecurityService.toggleMilitaryMode(context, value);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.cleaning_services_rounded, color: Colors.red),
                      title: const Text('Trigger Duress Data Wipe', style: TextStyle(color: Colors.redAccent)),
                      subtitle: const Text('Emergency PIN wipe protocol for sensitive logs'),
                      onTap: () => SecurityService.triggerDuressDataWipe(context),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'SentriX Intelligence Cores',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildCoresGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required Widget child}) {
    return Card(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF00ADB5), size: 20),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            const Divider(color: Colors.grey),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isLocked,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          isLocked ? Icons.lock : icon,
          color: isLocked ? Colors.redAccent : const Color(0xFF00ADB5),
        ),
        title: Text(title, style: TextStyle(color: isLocked ? Colors.grey : Colors.white)),
        subtitle: Text(subtitle, style: TextStyle(color: isLocked ? Colors.red.shade200 : Colors.grey)),
        trailing: isLocked ? const Icon(Icons.lock_outline, size: 18, color: Colors.grey) : const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildCoresGrid() {
    final cores = [
      'Core #1: Aura Automation',
      'Core #2: Security Vault',
      'Core #3: Data Sync & Cloud',
      'Core #4: Health Monitor',
      'Core #5: Smart Task Scheduler',
      'Core #6: Notification Hub',
      'Core #8: Speed Manager',
      'Core #9: System Logs',
      'Core #10: Emergency Recovery',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2.2,
      ),
      itemCount: cores.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF252525),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white10),
          ),
          padding: const EdgeInsets.all(6),
          child: Center(
            child: Text(
              cores[index],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.white70),
            ),
          ),
        );
      },
    );
  }
}
