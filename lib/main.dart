import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Helpers/route_generator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('it', 'IT')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      // change patch to your
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElysiumTech',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'ElysiumTech'),
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings, context),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/register');
              },
              child: Text('Registration Screen'.tr()),
            ),
            SizedBox(height: 12),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/data_entry');
              },
              child: Text('Data Entry Screen'.tr()),
            ),
            SizedBox(height: 12),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/upload_file');
              },
              child: Text('Upload file Screen'.tr()),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
