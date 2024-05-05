import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmacy_talk/categories/edit_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot> data = [];

  bool isLoading = true;

  getCategory() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .where(
      "id",
      isEqualTo: FirebaseAuth.instance.currentUser!.uid,
    ).get();

    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).pushNamed("addcategory");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 160),
        itemBuilder: (context, i) {
          return InkWell(
            onLongPress: () {
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,
                  title: 'warning',
                  desc: "اختر ماذا تريد؟",
                  btnCancelText: "حذف",
                  btnOkText: "تعديل",
                  btnCancelOnPress: () async {
                    await FirebaseFirestore.instance
                        .collection("categories")
                        .doc(data[i].id)
                        .delete();
                    Navigator.of(context)
                        .pushReplacementNamed("homepage");
                  },
                  btnOkOnPress: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            EditCategory(
                                docid: data[i].id, oldname: data[i]['name'])));
                  }).show();
            },
            child: Card(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/folder.png",
                      height: 100,
                    ),
                  ),
                  Text("${data[i]['name']}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
