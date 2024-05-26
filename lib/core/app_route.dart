import 'package:green_tech/src/view/screen/automatic_spray_screen.dart';
import 'package:green_tech/src/view/screen/automation_schedule_screen.dart';
import 'package:green_tech/src/view/screen/home_screen.dart';
import 'package:green_tech/src/view/screen/login_screen.dart';
import 'package:green_tech/src/view/screen/refill_status_screen.dart';
import 'package:green_tech/src/view/widget/bottom_navigation.dart';

class AppRoute {
  const AppRoute._();

  static const root = BottomNavigation();
  static const login = LoginScreen();
  static const home = HomeScreen();
  static const automaticSpray = AutomaticSprayScreen();
  static const refillStatus = RefillStatusScreen();
  static const automationSchedule = AutomationScheduleScreen();
}
