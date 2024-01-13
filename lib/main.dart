import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noted/firebase_options.dart';
import 'package:noted/views/login_view.dart';
import 'package:noted/views/register_view.dart';
import 'package:noted/views/verify_email_view.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView() 
      }
    ),
  );
}
//10:59:13
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: 
            Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                if (user != null){
                  if(user.emailVerified){
                    print('Email is verified.');
                  }
                  else{
                    return const VerifyEmailView();
                  }
                }
                else{
                  return const LoginView();
                }
                return const Text('Done');
          default: 
            return const CircularProgressIndicator();
          }  
          },
        );
  }
}

