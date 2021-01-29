import 'package:elysium_tech/Screens/data_entry_screen.dart';
import 'package:elysium_tech/Screens/registration_screen.dart';
import 'package:elysium_tech/Screens/upload_file_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings, context) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/register':
        return platformPageRoute(
          context: context,
          builder: (_) => RegistrationScreen(),
          settings: settings,
        );
      case '/data_entry':
        return platformPageRoute(
          context: context,
          builder: (_) => DataEntryScreen(),
          settings: settings,
        );
      case '/upload_file':
        return platformPageRoute(
          context: context,
          builder: (_) => UploadFileScreen(),
          settings: settings,
        );
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}