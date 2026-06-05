import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:inetrview_code_practices/sqf_life/database/database_helper.dart';
import 'package:inetrview_code_practices/sqf_life/models/profile.dart';
import 'package:inetrview_code_practices/sqf_life/screens/profile_form_screen.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileFormScreen(),
    );
  }
}

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context){

    final profile = useState<Profile?>(null);
    final isLoading = useState(true);

    final size = MediaQuery.of(context).size;

    Future<void> loadProfile() async {
      final result = await DatabaseHelper.instance.getProfile();
      profile.value = result;
      isLoading.value = false;
    }

   useEffect(() {
  loadProfile();
  return null;
}, []);

    return Scaffold(
      appBar: AppBar(title: Text('Profile'),),
      body: Container(
        width: size.width,
        height: size.height,
        child: Center(
          child: isLoading.value
          ? const CircularProgressIndicator()
          : profile.value == null
          ? const Text('No profile found')
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name: ${profile.value!.name}'),
              Text('Email: ${profile.value!.email}'),
            ],
        )
      )
      )
    );
  }
}