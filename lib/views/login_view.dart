import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noted/firebase_options.dart';
import 'dart:developer' as devtools show log;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
 
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

@override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login')
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your email here',
              ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false ,
            decoration: const InputDecoration(hintText: 'Enter your password here',)
          ),
          TextButton(
            onPressed: () async{
              final email = _email.text;
              final password = _password.text;
              try{
                await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                email: email, 
                password: password
              );
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/notes/', 
                  (route) => false
                ); //13:34:46
              }
      
              on FirebaseAuthException catch (e){
                if(e.code == 'invalid-credential'){
                  devtools.log('Invalid Credential. Check if your password is correct or if your account is registered.');
                }
                else {
                  devtools.log('something else happened');
                  devtools.log(e.code);
                }
              }
            },
            child: const Text('Login'),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/register/', 
                (route) => false
              );
            },
            child : const Text('Not registered yet? Register here!'),
          )
        ],
      ),
    );
  } 
}