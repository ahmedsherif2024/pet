import 'package:flutter/material.dart';
import 'package:pharmacy_talk/cat_page.dart';
import 'package:pharmacy_talk/dog_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<String> categories = [
    'Cats',
    'Dogs',
    'Parrots',
    'Fish',
  ];
  List imagename = [
    "assets/cat.png",
    'assets/dog.png',
    'assets/parrot.png',
    'assets/fish.png',
  ];

  List<Widget> screens = [
    //اسم الاسكرينه1
    //اسم الاسكرينه2
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.purple,
      //   onPressed: () {},
      //   child: Text(
      //     "history",
      //     style: TextStyle(
      //         fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "pet care",
          style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: 1,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home ), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Store"),
          BottomNavigationBarItem(icon: Icon(Icons.question_answer), label: "Medical Question"),
        ],
      ),
      body: //screens[currentIndex]
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 110,
              child: ListView(
                children: [
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 80,
                          width: 80,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                          ),
                          child: Image.asset("assets/cat.png",),
                        ),
                        Text(
                          "All",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CatScreen()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 80,
                            width: 80,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                            ),
                            child: Image.asset("assets/cat.png",),
                          ),
                          Text(
                            "Cats",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DogScreen()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 80,
                            width: 80,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                            ),
                            child: Image.asset("assets/dog.png",),
                          ),
                          Text(
                            "Dogs",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 80,
                          width: 80,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                          ),
                          child: Image.asset("assets/parrot.png",),
                        ),
                        Text(
                          "parrots",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(right: 10),
                          height: 80,
                          width: 80,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                          ),
                          child: Image.asset("assets/fish.png",),
                        ),
                        Text(
                          "Fish",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                                ),
                ),
            ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  height: 250,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[300]),
                  child: Image.asset("assets/cat.png"),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey , width: 0.3),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  height: 200,
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sola",
                            style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                                color: Colors.blue
                            ),
                          ),
                          Icon(Icons.female , color: Colors.grey,size: 30),
                        ],
                      ),
                      Text("Abyssinian", style: TextStyle(color: Colors.blue) ,),
                      SizedBox(height: 15,),
                      Text("2.0 years old", style: TextStyle(color: Colors.grey) ,),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Icon(Icons.location_on , color: Colors.blue,),
                          Text("3.6 Km")
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  height: 250,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[300]),
                  child: Image.asset("assets/dog.png"),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey , width: 0.3),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  height: 200,
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sola",
                            style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                                color: Colors.blue
                            ),
                          ),
                          Icon(Icons.female , color: Colors.grey,size: 30),
                        ],
                      ),
                      Text("Abyssinian", style: TextStyle(color: Colors.blue) ,),
                      SizedBox(height: 15,),
                      Text("2.0 years old", style: TextStyle(color: Colors.grey) ,),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Icon(Icons.location_on , color: Colors.blue,),
                          Text("3.6 Km")
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  height: 250,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[300]),
                  child: Image.asset("assets/parrot.png"),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey , width: 0.3),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  height: 200,
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sola",
                            style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                                color: Colors.blue
                            ),
                          ),
                          Icon(Icons.female , color: Colors.grey,size: 30),
                        ],
                      ),
                      Text("Abyssinian", style: TextStyle(color: Colors.blue) ,),
                      SizedBox(height: 15,),
                      Text("2.0 years old", style: TextStyle(color: Colors.grey) ,),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Icon(Icons.location_on , color: Colors.blue,),
                          Text("3.6 Km")
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  height: 250,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[300]),
                  child: Image.asset("assets/fish.png"),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey , width: 0.3),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  height: 200,
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sola",
                            style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                                color: Colors.blue
                            ),
                          ),
                          Icon(Icons.female , color: Colors.grey,size: 30),
                        ],
                      ),
                      Text("Abyssinian", style: TextStyle(color: Colors.blue) ,),
                      SizedBox(height: 15,),
                      Text("2.0 years old", style: TextStyle(color: Colors.grey) ,),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Icon(Icons.location_on , color: Colors.blue,),
                          Text("3.6 Km")
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
