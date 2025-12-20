import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // <-- вот этот импорт нужен
import 'firebase_options.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sign-In Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthService _authService = AuthService();
  User? user; // теперь тип User доступен

  @override
  void initState() {
    super.initState();
    _authService.authStateChanges.listen((u) {
      setState(() {
        user = u;
      });
      print("Signed in user: ${user?.email}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Sign-In")),
      body: Center(
        child: user == null
            ? ElevatedButton(
                onPressed: () async {
                  await _authService.signInWithGoogle();
                },
                child: const Text("Sign in with Google"),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Signed in as: ${user!.displayName}"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await _authService.signOut();
                    },
                    child: const Text("Sign out"),
                  ),
                ],
              ),
      ),
    );
  }
}
