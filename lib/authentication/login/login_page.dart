import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:volt_way/authentication/login/register.dart';
import 'package:volt_way/screen/home.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//
//       options: const FirebaseOptions(
//           apiKey:  "AIzaSyDjGC1iSVWuJLoKHpcScV-Iw4p-RM-uDe8",
//           appId: "1:1027977751981:android:b002b62e2d14845dd28524",
//           projectId:   "quiz-app-dd6c7",
//           storageBucket:  "quiz-app-dd6c7.appspot.com",
//           messagingSenderId: '')
//
//   );
//   runApp( const MaterialApp(debugShowCheckedModeBanner: false,
//     home: LoginScreen(),
//   ));
// }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formkey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  var email = TextEditingController();

  var password = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("Google sign-in error: $e");
      return null;
    }
  }

  Future<String?> SignIn() async {
    try {
      final log = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        e.message;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 50, right: 50, top: 60),
                child: Image(
                  image: AssetImage("assets/images/logbg.png"),
                  height: 250,
                  width: 250,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Container(
                  height: 500,
                  // Adjust height to accommodate the Google Sign-In button
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        // Email TextField
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: email,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: const TextStyle(color: Colors.white60),
                            prefixIcon: const Icon(Icons.mail),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          validator: (email) {
                            if (email!.isEmpty || !email.contains("@")) {
                              return "Invalid Email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // Password TextField
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          controller: password,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.white60),
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          validator: (pass) {
                            if (pass!.isEmpty || pass.length < 8) {
                              return "Password must be at least 8 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Login Button
                        ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              SignIn();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff201f30),
                            minimumSize: const Size(350, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 28,
                              fontFamily: "genos",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Register Text Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.white54),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Register(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(color: Color(0xff8282a6)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            "Or",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Google Sign-In Button
                        GestureDetector(
                          onTap: () async {
                            final user = await signInWithGoogle();
                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Color(0xff201f30),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage("assets/images/google.png"),
                                  height: 40,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Login with Google",
                                  style: TextStyle(color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
