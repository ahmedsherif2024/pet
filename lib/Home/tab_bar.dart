import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_talk/Home/details_Cats.dart';
import 'package:pharmacy_talk/Home/details_birds.dart';
import 'package:pharmacy_talk/Home/details_dogs.dart';
import 'package:pharmacy_talk/Home/details_fishs.dart';
import 'package:pharmacy_talk/Model/birds.dart';
import 'package:pharmacy_talk/Model/cats.dart';
import 'package:pharmacy_talk/Model/dogs.dart';
import 'package:pharmacy_talk/Model/fish.dart';
import 'package:pharmacy_talk/Utils/firebase_utils_birds.dart';
import 'package:pharmacy_talk/Utils/firebase_utils_cats.dart';
import 'package:pharmacy_talk/Utils/firebase_utils_dogs.dart';
import 'package:pharmacy_talk/Utils/firebase_utils_fishs.dart';

class Tab_Bar_Screen extends StatefulWidget {
  static const String routeName = 'Tab_Bar';

  @override
  State<Tab_Bar_Screen> createState() => _Tab_Bar_ScreenState();
}

class _Tab_Bar_ScreenState extends State<Tab_Bar_Screen> {
  List<Dogs> dogs = [];
  List<Cats> cats = [];
  List<Birds> birds = [];
  List<Fishs> fishs = [];

  @override
  Widget build(BuildContext context) {
    getDataDogs();
    getDataCats();
    getDataFishs();
    getDataBirds();
    return Scaffold(
      backgroundColor: Color(0xffEAE9E5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Pet Shop',
          style: TextStyle(
              color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: DefaultTabController(
            length: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Search for products",
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                ButtonsTabBar(
                  height: 50,
                  buttonMargin:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  borderColor: Colors.transparent,
                  unselectedBackgroundColor: Colors.transparent,
                  unselectedBorderColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  borderWidth: 4,
                  unselectedLabelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  labelStyle: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  tabs: [
                    Tab(
                      text: "Dogs",
                    ),
                    Tab(
                      text: "Cats",
                    ),
                    Tab(
                      text: "Birds",
                    ),
                    Tab(
                      text: "Fishs",
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                  child: TabBarView(
                    children: [
                      GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 250,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 11,
                                  crossAxisSpacing: 11),
                          itemBuilder: (context, index) =>
                              Tab_Bar_Ui_Dogs(dogs: dogs[index]),
                          itemCount: dogs.length),
                      GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 250,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 11,
                                  crossAxisSpacing: 11),
                          itemBuilder: (context, index) =>
                              Tab_Bar_Ui_Cats(cats: cats[index]),
                          itemCount: cats.length),
                      GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 250,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 11,
                                  crossAxisSpacing: 11),
                          itemBuilder: (context, index) =>
                              Tab_Bar_Ui_Birds(birds: birds[index]),
                          itemCount: birds.length),
                      GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 250,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 11,
                                  crossAxisSpacing: 11),
                          itemBuilder: (context, index) =>
                              Tab_Bar_Ui_Fishs(fishs: fishs[index]),
                          itemCount: fishs.length),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDataDogs() async {
    QuerySnapshot<Dogs> querySnapshot = await getDogs().get();
    dogs = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    setState(() {});
  }

  getDataCats() async {
    QuerySnapshot<Cats> querySnapshot = await getCatsFromFirebase().get();
    cats = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    setState(() {});
  }

  getDataBirds() async {
    QuerySnapshot<Birds> querySnapshot = await getBirdsFromFirebase().get();
    birds = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    setState(() {});
  }

  getDataFishs() async {
    QuerySnapshot<Fishs> querySnapshot = await getFishsFromFirebase().get();
    fishs = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    setState(() {});
  }
}

class Tab_Bar_Ui_Dogs extends StatelessWidget {
  Dogs dogs;

  Tab_Bar_Ui_Dogs({required this.dogs});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Specify the width
      height: 320, // Specify the height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.network(
              "${dogs.image}",
              height: 140,
            ),
            Text(
              "${dogs.title}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${dogs.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.purple),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Details_Dogs.routeName,
                          arguments: ScreenArgsDogs(
                              id: dogs.id,
                              title: dogs.title,
                              desc: dogs.desc,
                              price: dogs.price,
                              image: dogs.image,
                              quantity: dogs.quantity));
                    },
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.purple,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Tab_Bar_Ui_Cats extends StatelessWidget {
  Cats cats;

  Tab_Bar_Ui_Cats({required this.cats});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Specify the width
      height: 320, // Specify the height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.network(
              "${cats.image}",
              height: 140,
            ),
            Text(
              "${cats.title}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${cats.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.purple),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Details_Cats.routeName,
                          arguments: ScreenArgsCats(
                              id: cats.id,
                              title: cats.title,
                              desc: cats.desc,
                              price: cats.price,
                              image: cats.image,
                              quantity: cats.quantity));
                    },
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.purple,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Tab_Bar_Ui_Birds extends StatelessWidget {
  Birds birds;

  Tab_Bar_Ui_Birds({required this.birds});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Specify the width
      height: 320, // Specify the height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.network(
              "${birds.image}",
              height: 140,
            ),
            Text(
              "${birds.title}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${birds.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.purple),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Details_Birds.routeName,
                          arguments: ScreenArgsBirds(
                              id: birds.id,
                              title: birds.title,
                              desc: birds.desc,
                              price: birds.price,
                              image: birds.image,
                              quantity: birds.quantity));
                    },
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.purple,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Tab_Bar_Ui_Fishs extends StatelessWidget {
  Fishs fishs;

  Tab_Bar_Ui_Fishs({required this.fishs});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Specify the width
      height: 320, // Specify the height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.network(
              "${fishs.image}",
              height: 140,
            ),
            Text(
              "${fishs.title}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${fishs.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.purple),
                ),
                IconButton(
                    onPressed: () { Navigator.of(context).pushNamed(Details_Fishs.routeName,
                        arguments: ScreenArgsFishs(
                            id: fishs.id,
                            title: fishs.title,
                            desc: fishs.desc,
                            price: fishs.price,
                            image: fishs.image,
                            quantity: fishs.quantity));},
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.purple,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ScreenArgsDogs {
  String id;
  String title;
  String desc;
  String price;
  String image;
  String quantity;

  ScreenArgsDogs({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.image,
    required this.quantity,
  });
}
class ScreenArgsCats {
  String id;
  String title;
  String desc;
  String price;
  String image;
  String quantity;

  ScreenArgsCats({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.image,
    required this.quantity,
  });
}
class ScreenArgsBirds {
  String id;
  String title;
  String desc;
  String price;
  String image;
  String quantity;

  ScreenArgsBirds({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.image,
    required this.quantity,
  });
}
class ScreenArgsFishs {
  String id;
  String title;
  String desc;
  String price;
  String image;
  String quantity;

  ScreenArgsFishs({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.image,
    required this.quantity,
  });
}
