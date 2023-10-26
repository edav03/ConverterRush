import 'package:converterrush/routes/routes.dart';
import 'package:converterrush/services/main_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

late Future<Database> database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PagesDataService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Converter',
        initialRoute: 'landingScreen',
        routes: appRoutes,
      ),
    );
  }
}
