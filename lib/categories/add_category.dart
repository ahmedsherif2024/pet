import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

  bool isLoading = false;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  CollectionReference categories = FirebaseFirestore.instance.collection("categories");

  addCategory() async{
    if(formstate.currentState!.validate()){
      try{
        isLoading = true;
        setState(() {

        });
        DocumentReference response = await categories.add({
          "name" : name.text,
          "id" : FirebaseAuth.instance.currentUser!.uid,
        });
        Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
      }catch(e){
        isLoading = false;
        setState(() {

        });
        print("Error $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: Form(
        key: formstate,
        child: isLoading ? Center(child: CircularProgressIndicator(),) : ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25 , vertical: 20),
              child: TextFormField(
                controller: name,
                validator: (value) {
                  if (value == ""){
                    return "Can't is empty";
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  hintText: "Enter Name",

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 120),

              child: MaterialButton(
                onPressed: ()
                {
                  addCategory();
                },
                color: Colors.orange,
                textColor: Colors.white,
                child: Text("add" , style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
