import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:inetrview_code_practices/sqf_life/database/database_helper.dart';
import 'package:inetrview_code_practices/sqf_life/models/profile.dart';
import 'package:inetrview_code_practices/sqf_life/screens/profile_screen.dart';

class ProfileFormScreen extends HookWidget {
  const ProfileFormScreen({super.key});

  Future<void> saveProfile(
    TextEditingController nameController,
    TextEditingController emailController,
    BuildContext context,
  ) async {
    final existingProfile = await DatabaseHelper.instance.getProfile();

    if (existingProfile != null) {
      await DatabaseHelper.instance.updateProfile(
        Profile(
          id: existingProfile.id,
          name: nameController.text,
          email: emailController.text,
        ),
      );
    } else {
      await DatabaseHelper.instance.insertProfile(
        Profile(
          name: nameController.text,
          email: emailController.text,
        ),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

  Future<void> clearDB(
    TextEditingController nameController,
    TextEditingController emailController,
  ) async {
    await DatabaseHelper.instance.clearProfileDBData();

    nameController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () =>
                saveProfile(nameController, emailController, context),
            child: Text('Save'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await clearDB(
                nameController,
                emailController,
              );
            },
            child: const Text('Clear'),
          )
        ],
      ),
    );
  }
}
