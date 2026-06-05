import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inetrview_code_practices/cubit/cubit_main.dart';
import 'package:inetrview_code_practices/flutter_hooks/flutter_hooks_practice.dart';
import 'package:inetrview_code_practices/native_code/services/platform_service.dart';
import 'package:inetrview_code_practices/sqf_life/database/database_helper.dart';
import 'package:inetrview_code_practices/sqf_life/screens/profile_screen.dart';

import 'scratch/di/injection_container.dart';
import 'scratch/main.dart';

void main() async {
  // runApp(const MyApp());
  // runApp(const CubitMain());
  // runApp(const ShopEase());
  // runApp(const FlutterHooksPractice());
  
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await DatabaseHelper.instance.database;
  runApp(const ProfileApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _platformVersion = '';

  PlatformService platformService = PlatformService();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

// 3. Create a logic function to handle the async call
  Future<void> _loadVersion() async {
    try {
      final version = await platformService.getPlatformVersion();
      
      // 4. Update the UI state with the result
      if (mounted) {
        setState(() {
          _platformVersion = version ?? 'Unknown Platform';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _platformVersion = 'Failed to get version';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(
              'Android Platform Version: $_platformVersion',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await platformService.showToast("Hello from Flutter!");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
