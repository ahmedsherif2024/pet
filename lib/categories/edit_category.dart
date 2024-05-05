import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditCategory extends StatefulWidget {
  final String docid;
  final String oldname;
  const EditCategory({super.key, required this.docid, required this.oldname});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {

  bool isLoading = false;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  CollectionReference categories = FirebaseFirestore.instance.collection("categories");

  editCategory() async{
    if(formstate.currentState!.validate()){
      try{
        isLoading = true;
        setState(() {
        });
         await categories.doc(widget.docid).update({
          "name" : name.text
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
  void initState() {
    name.text = widget.oldname;
    super.initState();
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
                  editCategory();
                },
                color: Colors.orange,
                textColor: Colors.white,
                child: Text("Save" , style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
