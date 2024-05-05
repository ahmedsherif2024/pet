import 'package:flutter/material.dart';

class CatScreen extends StatefulWidget {
  const CatScreen({super.key});

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {

  List items = [
    {
      "image" : "assets/siamese.png",
      "title" : "Siamese ",
      "subtitle" : "Healthy diet: Choose balanced and nutritious food that meets your Siamese cat's dietary needs."
          "Fur care: Regularly groom your cat's coat using a suitable brush for its short, dense fur."
          "Personal hygiene: Provide clean water for drinking and ensure daily sanitation of the litter box."
          "Physical activity: Allocate daily time for your Siamese cat to exercise and play to maintain physical fitness and mental stimulation."
          "Regular check-ups: Schedule regular visits to the veterinarian for health check-ups and necessary vaccinations.",
    },
    {
      "image" : "assets/happy.png",
      "title" : "Shirazi",
      "subtitle" :"Clean fur: Regularly groom your Persian cat's fur using a suitable brush to maintain its softness and beauty."
          "Litter box cleanliness: Clean the litter box regularly and change the litter as needed to keep a clean environment for your cat."
          "Play and interaction: Allocate daily time for play and interaction with your cat to strengthen your bond and provide entertainment and activity."
          "Regular vet visits: Schedule regular veterinary check-ups for your Persian cat to receive necessary vaccinations and preventive treatments.",
    },
    {
      "image" : "",
      "title" : "",
      "subtitle" : "",
    },
    {
      "image" : "",
      "title" : "",
      "subtitle" : "",
    },
    {
      "image" : "",
      "title" : "",
      "subtitle" : "",
    },
    {
      "image" : "",
      "title" : "",
      "subtitle" : "",
    },
    {
      "image" : "",
      "title" : "",
      "subtitle" : "",
    },
    {
      "image" : "",
      "title" : "",
      "subtitle" : "",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cat Category", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        children: [
          GridView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset(items[index]['image'] , height: 80,)),
                      Text(items[index]['title'] , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),
                      Text(items[index]['subtitle'],style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),),
                    ],
                  ),
                ),
              );
            },
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,mainAxisExtent: 420)),

        ],
      ),
    );
  }
}
