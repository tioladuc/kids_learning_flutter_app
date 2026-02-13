import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../state/session_provider.dart';
import 'audio_list_screen.dart';


////////////////////////////////////////////////////////////////////////
class LoginScreen extends StatefulWidget {
  
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

////////////////////////////////////////////////////////////////////////
class _LoginScreen  extends State<LoginScreen> {
  //const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerLogin = TextEditingController();
    final controllerPwd = TextEditingController();
    String selectedProfile = "USA";
 List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(value: "USA", child: Text("USA")),
    DropdownMenuItem(value: "Canada", child: Text("Canada")),
    DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
    DropdownMenuItem(value: "England", child: Text("England")),
  ];


  print('ssdsdsds');

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            DropdownButton(
              value: selectedProfile,
              onChanged: (String? newValue){
                setState(() {
                  selectedProfile = newValue!;
                });
              },
              items: menuItems
              ),


            TextField(
              controller: controllerLogin,
              decoration: const InputDecoration(labelText: 'Login'),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: controllerPwd,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () async {
                print('asddsdd');
                final user = await AuthService.login(selectedProfile, controllerLogin.text, controllerPwd.text);
                context.read<SessionProvider>().setUser(user);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AudioListScreen()),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
