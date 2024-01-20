import 'package:flutter/material.dart';
import 'package:noted/constants/routes.dart';
import 'package:noted/services/auth/auth_service.dart';
import 'package:noted/views/login_view.dart';
import 'package:noted/views/notes_view.dart';
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
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      } //13:45:31
    ),
  );
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: AuthService.firebase().initialize(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.done:
                final user = AuthService.firebase().currentUser;
                if (user != null){
                  if(user.isEmailVerified){
                    return const NotesView();
                  }
                  else{
                    return const VerifyEmailView();
                  }
                }
                else{
                  return const LoginView();
                }
          default: 
            return const CircularProgressIndicator();
          }  
          },
        );
  }
}