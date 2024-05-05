// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List items = [
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "assets/615lTEeCu8L._AC_UF1000,1000_QL80_.jpg",
//       "title": "اكسيرا",
//       "subtitle": "دراي فود اكسيرا للكلاب البالغة 20 كيلوجرام",
//       "price" : "1,150.00 £*",
//     },
//     {
//       "image": "assets/1.jpg",
//       "title": "الفا",
//       "subtitle":"دراي فود الفا للكلاب البالغة 20 كيلوجرام",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//     {
//       "image": "",
//       "title": "",
//       "subtitle": "",
//       "quantity": "",
//       "price" : "",
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                   padding: EdgeInsets.all(20),
//                   child: Text("Pet Shop", style: TextStyle(fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.purple),)),
//
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 15),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintText: "Search for products",
//                     suffixIcon: Icon(Icons.search),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     TextButton(onPressed: () {}, child: Text("All")),
//                     SizedBox(width: 10,),
//                     TextButton(onPressed: () {}, child: Text("Dogs")),
//                     SizedBox(width: 10,),
//                     TextButton(onPressed: () {}, child: Text("Cats")),
//                     SizedBox(width: 10,),
//                     TextButton(onPressed: () {}, child: Text("Fish")),
//                     SizedBox(width: 10,),
//                     TextButton(onPressed: () {}, child: Text("Birds")),
//                   ],
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 child: GridView.builder(
//
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: Container(
//                         height: double.infinity,
//                         padding: EdgeInsets.all(15),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                                 padding: EdgeInsets.all(15),
//                                 child: Image.asset(
//                               items[index]['image'], height: 100,)),
//                             Text(items[index]['title'], style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 25),),
//                             Text(items[index]['subtitle'], style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 15),),
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(items[index]['price'], style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 15),),
//                                 IconButton(onPressed: (){}, icon: Icon(Icons.shopping_basket))
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   itemCount: items.length,
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, mainAxisExtent: 300),),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
