import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//
//       options: const FirebaseOptions(
//           apiKey: "AIzaSyAoLL-q9Yb_pH5bVg1cXXr9mufZzYZu9uQ",
//           appId: "1:575239563660:android:64a50c37224b34cb330ea9",
//           projectId: "quziz-app",
//           storageBucket: "quziz-app.appspot.com",
//           messagingSenderId: '')
//
//   );
//   runApp(MaterialApp(
//     home: Register(),
//   ));
// }

class Register extends StatefulWidget {
  const Register({super.key});


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final formkey1 = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var conpass = TextEditingController();

  Future<void> signUp() async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      await firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({'name': name.text, 'email': email.text});
      if (userCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } on FirebaseAuthException
    catch (e) {
      setState(() {
        e.message;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: formkey1,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 80, right: 50, top: 60),
                child: Image(
                  image: AssetImage("assets/images/logbg.png"),
                  height: 250,
                  width: 250,),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Container(height: 550,
                  decoration: BoxDecoration(color: Colors.white12,
                    borderRadius: BorderRadius.circular(13),

                  ),


                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(style: const TextStyle(
                            color: Colors.white
                        ),
                          controller: name,
                          decoration: InputDecoration(
                              hintText: "Username",
                              hintStyle: const TextStyle(
                                  color: Colors.white60
                              ),
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(13)
                              )

                          ),
                          validator: (name) {
                            if (name!.isEmpty) {
                              return "Field is empty";
                              return null;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(

                          style: const TextStyle(color: Colors.white),
                          controller: email,
                          decoration: InputDecoration(

                              hintText: "Email",
                              hintStyle: const TextStyle(
                                  color: Colors.white60
                              ),
                              prefixIcon: const Icon(Icons.mail),
                              border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(13)
                              )

                          ),
                          validator: (email) {
                            if (email!.isEmpty && email.contains("@") &&
                                email.contains(".")) {
                              return "Invalid Email";
                              return null;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(controller: password,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                  color: Colors.white60
                              ),
                              prefixIcon: const Icon(Icons.lock),
                              border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(13)
                              )

                          ),
                          validator: (pass) {
                            if (pass!.isEmpty && pass.length == 8) {
                              return "Password must be atleast 8";
                              return null;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(controller: conpass,
                            obscureText: true,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: const TextStyle(
                                    color: Colors.white60
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                border: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(13)
                                )

                            ),
                            validator: (cpass) {
                              if (cpass!.isEmpty && conpass == password) {
                                return "Password Incorrect";
                                return null;
                              }
                              return null;
                            }
                        ),
                        const SizedBox(height: 20,),
                        ElevatedButton(onPressed: () {
                          if (formkey1.currentState!.validate()) {
                            signUp();
                          }
                        },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff8282a6),
                              minimumSize: const Size(350, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)
                              )
                          ),
                          child: const Text("Register", style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontFamily: "genos",
                              fontWeight: FontWeight.bold),),),
                        const SizedBox(height: 15,),

                        // Container(height: 50, width: 350,
                        //   decoration: BoxDecoration(
                        //       color: Colors.lightGreen[200],
                        //       borderRadius: BorderRadius.circular(13)
                        //
                        //   ),
                        //   child: const Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Image(image: AssetImage(
                        //           "assets/images/google .png"), height: 30,),
                        //       SizedBox(width: 10,),
                        //       Text("Login with Google", style: TextStyle(
                        //           fontWeight: FontWeight.bold
                        //       ),)
                        //     ],
                        //   ),),
                        const SizedBox(height: 10,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already  have an accout?",style:TextStyle(
                                color: Colors.white
                            ),),
                            TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            }, child: const Text("Login",style:TextStyle(
                                color: Color(0xff8282a6)
                            ),)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}