import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_talk/Home/details_Cats.dart';
import 'package:pharmacy_talk/Home/details_birds.dart';
import 'package:pharmacy_talk/Home/details_dogs.dart';
import 'package:pharmacy_talk/Home/details_fishs.dart';
import 'package:pharmacy_talk/Home/tab_bar.dart';
import 'package:pharmacy_talk/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Pharmacy',
       theme: ThemeData(
         useMaterial3: true,
         colorScheme: ColorScheme.fromSeed(brightness: Brightness.light,
           seedColor: const Color.fromARGB(255, 171, 222, 244),),
         appBarTheme: AppBarTheme(
           iconTheme: IconThemeData(
             color: Colors.orange,
           ),
           elevation: 2.2,
           titleTextStyle: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.bold,
             color: Colors.orange,
           )
         ),
       ),

      // home: (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified)
      // ?HomePage1():LoginScreen(),

      // Scaffold(
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //   appBar: AppBar(
      //     title: Text('flutter'),
      //   ),
      //   body: ChatWidget(apiKey: "AIzaSyA9M-kuuNbUk18JABd8XMXB5FK8l3upQrE"),
      // ),
       initialRoute:Tab_Bar_Screen.routeName ,
      routes: {
        Tab_Bar_Screen.routeName : (context) => Tab_Bar_Screen(),
        Details_Dogs.routeName:(context) => Details_Dogs(),
        Details_Cats.routeName:(context) => Details_Cats(),
        Details_Birds.routeName:(context) => Details_Birds(),
        Details_Fishs.routeName:(context) => Details_Fishs()
      },

      // routes: {
      //   "signupp": (context) => SignUpScreen(),
      //   "login" : (context) => LoginScreen(),
      //   "homepage" : (context) => HomePage(),
      //   "addcategory" : (context) => AddCategory(),
      // },
    );
  }
}
