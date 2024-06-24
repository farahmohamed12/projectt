// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'ProductInfo.dart';

// class RatingPage extends StatefulWidget {
//   final double averageRating; // Add a parameter to accept average rating
//   final String userName; // Add a parameter to accept user's name
//   const RatingPage({Key? key, required this.averageRating, required this.userName}) : super(key: key);

//   @override
//   State<RatingPage> createState() => _RatingPage();
// }

// class _RatingPage extends State<RatingPage> {
//   TextEditingController commentController = TextEditingController(); // Step 1

//   int totalReviews = 100; // Total reviews for the product
//   // Sample rating distribution
//   Map<int, int> ratingDistribution = {
//     5: 50,
//     4: 30,
//     3: 10,
//     2: 5,
//     1: 5,
//   };

//   List<Map<String, String>> comments = []; // List to hold comments with user names

//   @override
//   Widget build(BuildContext context) {
//     double averageRating = widget.averageRating;
//     String userName = widget.userName;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 249, 212, 255),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(builder: (BuildContext context) => const ProductInfo()),
//             );
//           },
//           icon: const Icon(Icons.arrow_circle_left_outlined),
//         ),
//         title: const Text(
//           "Reviews & Ratings",
//           style: TextStyle(
//             fontSize: 20,
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 15),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.0),
//               child: Text(
//                 "Ratings and reviews are verified and are from people who use the same type of device that you use.",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   // Average rating and total reviews
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Average 
//                       //SizedBox(width: 20),
//                       Text(
//                         '$averageRating',
//                         style: const TextStyle(
//                           fontSize: 50,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       // Total reviews
//                       Text(
//                         'Total Reviews: $totalReviews',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Add your rating: ',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       // Rating bar with stars
//                       RatingBar.builder(
//                         initialRating: 0,
//                         minRating: 1,
//                         direction: Axis.horizontal,
//                         allowHalfRating: true,
//                         itemCount: 5,
//                         itemSize: 28,
//                         itemBuilder: (context, _) => const Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                         ),
//                         onRatingUpdate: (rating) {
//                           print(rating);
//                         },
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 20), // Spacer between rating section and bar chart
//                   // Rating distribution bar chart
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: ratingDistribution.entries.map((entry) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 5.0),
//                           child: Row(
//                             children: [
//                               Text(
//                                 '${entry.key}',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
//                                   child: LinearProgressIndicator(
//                                     value: entry.value / totalReviews,
//                                     minHeight: 10,
//                                     backgroundColor: const Color.fromARGB(255, 172, 168, 169),
//                                     valueColor: const AlwaysStoppedAnimation(Color.fromARGB(255, 232, 130, 248)),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Divider( // Adding a divider below the rating distribution bar chart
//               color: Colors.black,
//               thickness: 1,
//               height: 10,
//               indent: 20,
//               endIndent: 20,
//             ),
//             // Add your comment section here
//             SizedBox(height: 15),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Text(
//                     'Add your comment:',
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: TextField(
//                     controller: commentController, // Step 2
//                     maxLines: 4,
//                     decoration: InputDecoration(
//                       hintText: 'Type your comment here...',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       String comment = commentController.text;
//                       // Append the comment with the user's name to the comments list
//                       setState(() {
//                         comments.add({"name": userName, "comment": comment});
//                       });
//                       // Optionally, you can clear the text field after submission.
//                       commentController.clear();
//                     },
//                     child: Text(
//                       'Submit',
//                       style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 232, 130, 248),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Displaying the list of comments
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: comments.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '${comments[index]["name"]} :',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             '${comments[index]["comment"]}',
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
