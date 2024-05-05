import 'package:flutter/material.dart';

class DogScreen extends StatefulWidget {
  const DogScreen({super.key});

  @override
  State<DogScreen> createState() => _DogScreenState();
}

class _DogScreenState extends State<DogScreen> {
  List items = [
    {
      "image" : "assets/dog/dog1.jpg",
      "title" : "Frensh Bulldog",
      "subtitle" : "French bulldog ranked top breed in Detroit by American Kennel Club‏",
    },
    {
      "image" : "assets/dog/dog2.jpg",
      "title" : "Golden Frensh Bulldog",
      "subtitle" : "The Frenchie is playful, alert, adaptable, and completely irresistible.",
    },
    {
      "image" : "assets/dog/dog3.jpg",
      "title" : "Yorkshire Terrier Puppy",
      "subtitle" : " compact, toy-size terrier of no more than seven pounds whose crowning glory is a floor-length, silky coat of steel blue and a rich golden tan",
    },
    {
      "image" : "assets/dog/dog4.jpg",
      "title" : "Beagle Dog Puppy",
      "subtitle" : "Amiable، Curious، Even Tempered، Intelligent، Friendly، Determined، Alert، Bold، Gentle، Excitable، Independent، Merry",
    },
    {
      "image" : "assets/dog/dog5.jpg",
      "title" : "Maltese Dog Shih Tzu Pekingese Yorkshire Terrier Havanese Dog PN",
      "subtitle" : "Pekingese Yorkshire Terrier Havanese Dog PN",
    },
    {
      "image" : "assets/dog/dogs.png",
      "title" : "Labrador retriever",
      "subtitle" : "French bulldog ranked top breed in Detroit by American Kennel Club‏",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Dog Category"),
      ),
      body: ListView(
        children: [
          Container(

            child: GridView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      height: double.infinity,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Image.asset(items[index]['image'] ,
                                height: 100, )),
                          SizedBox(height: 20,),
                          Text(items[index]['title'] , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
                          Text(items[index]['subtitle'],style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),),
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,mainAxisExtent: 380)),
          ),

        ],
      ),
    );
  }
}
