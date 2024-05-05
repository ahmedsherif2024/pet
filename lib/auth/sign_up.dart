import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_talk/auth/login_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                Image.asset("assets/happy.png" ,  fit: BoxFit.cover,),
                TextFormField(
                  controller: username,
                  keyboardType: TextInputType.name,
                  onFieldSubmitted: (value){
                    print(value);
                  },
                  onChanged: (value){
                    print(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return 'user name must not be empty';
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.drive_file_rename_outline_sharp , color: Colors.purple),
                    labelText: "user name",
                  ),
                ),
                SizedBox(height: 15,),
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
                    labelText: "email address",
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
                      }
                      try {
                        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailcontroller.text,
                          password: passwordcontroller.text,
                        );
                        Navigator.of(context).pushReplacementNamed("login");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The password provided is too weak',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          )..show();
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The account already exists for that email',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          )..show();
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "have an account ?",
                    ),
                    TextButton(
                      onPressed: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "login",
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
