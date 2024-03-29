import 'package:flutter/material.dart';
import 'package:noted/constants/routes.dart';
import 'package:noted/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify your email.')
      ),
      body: Column(
        children: [
          const Text("We've sent you an email verification, please verify it to verify your account."),
          const Text("If you haven't receive the email verification, tap on the button below."),
          TextButton(
            onPressed: () async{
              await AuthService.firebase().sendEmailVerification();
          }, 
          child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed: () async {
              AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            }, 
            child: const Text('Restart'),
            )
        ],
      ),
    );
  }
}