import 'package:converterrush/pages/dashboard_screen.dart';
import 'package:converterrush/pages/html_screen.dart';
import 'package:converterrush/pages/landing_screen.dart';
import 'package:converterrush/pages/login_screen.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'landingScreen': (_) => const LandingScreen(),
  'loginScreen': (_) => LoginScreen(),
  'dashboardScreen': (_) => DashboardScreen(),
  'htmlScreen': (_) => const HTMLScreen(),
};
