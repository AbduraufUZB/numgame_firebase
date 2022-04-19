import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(controller: emailController),
          TextFormField(controller: passController),
          ElevatedButton(
            onPressed: signUp,
            child: const Text("Sign up"),
          ),
          ElevatedButton(
            onPressed: signIn,
            child: const Text("Sign in"),
          ),
          ElevatedButton(
            onPressed: forgotPassword,
            child: const Text("forgor password"),
          ),
          ElevatedButton(
            onPressed: loginWithOtp,
            child: const Text("Login with OTP"),
          ),
        ],
      ),
    );
  }

  Future signUp() async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passController.text);
      showMySnackBar("Success: " + user.user!.email.toString(), Colors.green);
      //await auth.currentUser!.sendEmailVerification();
      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        showMySnackBar("The password provided is too weak", Colors.red);
      } else if (e.code == "email-already-in-use") {
        showMySnackBar("The email already exists", Colors.red);
      }
    }
  }

  Future signIn() async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);
      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showMySnackBar("No user found for that email", Colors.red);
      } else if (e.code == "wrong-password") {
        showMySnackBar("Wrong password provided for that user", Colors.red);
      }
    }
  }

  Future loginWithOtp() async {
    await auth.verifyPhoneNumber(
      phoneNumber: emailController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == "invalid-phone-number") {
          showMySnackBar("The provider phone number is not valid.", Colors.red);
        } else {
          showMySnackBar("Another Error type: ${e.message}", Colors.red);
          print("Another Error type: ${e.message}");
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = passController.text;

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
        await auth.signInWithCredential(credential);

        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      },
      codeAutoRetrievalTimeout: (String vertificationId) {},
    );
  }

  Future forgotPassword() async {
    await auth.sendPasswordResetEmail(email: emailController.text);
    showMySnackBar("password reset link is sent to email", Colors.green);
  }

  showMySnackBar(String content, Color color) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: color,
    ));
  }
}
