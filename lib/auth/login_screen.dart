import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmacy_talk/auth/sign_up.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:pharmacy_talk/test_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool isLoading = false;

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    isLoading = true;
    setState(() {

    });
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser == null){
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    isLoading = false;
    setState(() {

    });

    // Once signed in, return the UserCredential
     await FirebaseAuth.instance.signInWithCredential(credential);
     Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? Center(child: CircularProgressIndicator(),) :  Form(
        key: formstate,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children:[
                Text(
                  "Pet care",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple
                  ),
                  textAlign: TextAlign.center,
                ),
                Image.asset("assets/happy.png" , fit: BoxFit.cover,),
                TextFormField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value){
                    print(value);
                  },
                  onChanged: (value){
                    print(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return 'email address must not be empty';
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.email , color: Colors.purple),
                    labelText: "Email",
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: passwordcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onFieldSubmitted: (value){
                    print(value);
                  },
                  onChanged: (value){
                    print(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return 'password must not be empty';
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: Icon(Icons.remove_red_eye_outlined , color: Colors.purple),
                    labelText: "Password",
                  ),
                ),
                SizedBox(height: 7,),
               InkWell(
                 onTap: () async
                 {

                   if (emailcontroller.text == ""){
                     AwesomeDialog(
                       context: context,
                       dialogType: DialogType.error,
                       animType: AnimType.rightSlide,
                       title: 'Error',
                       desc: 'الرجاء كتابه البريد الالكتروني ثم قم بالضغط علي forget password',
                     ).show();
                     return;
                   }
                   try{
                     await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text);
                     AwesomeDialog(
                       context: context,
                       dialogType: DialogType.error,
                       animType: AnimType.rightSlide,
                       title: 'Error',
                       desc: 'الرجاء الذهاب الي بريدك الالكتوني لاعاده كتابه كلمه سر جديده',
                     ).show();
                   }catch(e){
                     AwesomeDialog(
                       context: context,
                       dialogType: DialogType.error,
                       animType: AnimType.rightSlide,
                       title: 'Error',
                       desc: 'الرجاء التاكد من ان البريد الالكتروني صحيح',
                     ).show();
                   }
                 },
                 child: Container(
                   alignment: Alignment.topRight,
                   child :  Text("forget password ? " , style: TextStyle(fontSize: 14),),
                 ),
               ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.purple,
                  ),
                  child: MaterialButton(
                    textColor: Colors.white,
                    onPressed: () async
                    {
                      if(formstate.currentState!.validate())
                        {
                          print(emailcontroller.text);
                          print(passwordcontroller.text);
                          try {
                            isLoading = true;
                            setState(() {

                            });
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailcontroller.text,
                              password: passwordcontroller.text,
                            );
                            isLoading = false;
                            setState(() {

                            });
                            if(credential.user!.emailVerified){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TestScreen()));
                            }else{
                              FirebaseAuth.instance.currentUser!.sendEmailVerification();
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'الرجاء التوجه الي بريدك الالكتوني لكي تتحقق من الدخول',
                              ).show();
                            }
                          } on FirebaseAuthException catch (e) {
                            isLoading = false;
                            setState(() {

                            });
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'No user found for that email',
                              ).show();

                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'Wrong password provided for that user',
                              ).show();
                            }
                          }
                        }else{
                        print("Not Validate");
                      }
                    },
                    child: Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.purple,
                  ),
                  child: MaterialButton(
                    textColor: Colors.white,
                    onPressed: ()
                    {
                      signInWithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/search.png" , fit: BoxFit.cover,width: 20,height: 20,),
                       Text(
                         "Login With Google",
                       ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Don't have an account?",
                    ),
                   TextButton(
                       onPressed: ()
                       {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                       },
                       child: Text(
                         " Sign Up",
                         style: TextStyle(
                             color: Colors.purple
                         ),
                       ),
                   ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
