import 'dart:math';

/// अंतरिक्ष के समय अंतर (Relativistic Time Dilation) और यूनिवर्सल कोऑर्डिनेट्स का कॉन्फ़िगरेशन।
class SpaceTimeConfig {
  static const double speedOfLight = 299792458; // meters per second

  /// आइंस्टीन के सापेक्षता नियम अनुसार Lorentz Factor गामा (γ) की गणना
  double calculateTimeDilation({required double velocity}) {
    if (velocity >= speedOfLight) return double.infinity;
    double factor = sqrt(1 - pow(velocity / speedOfLight, 2));
    return 1 / factor;
  }

  /// अंतरिक्ष दूरी और देरी (Space Delay Tolerance) सिंक
  Duration calculateSpaceDelay(double distanceInKm) {
    double timeInSeconds = (distanceInKm * 1000) / speedOfLight;
    return Duration(milliseconds: (timeInSeconds * 1000).toInt());
  }
}
