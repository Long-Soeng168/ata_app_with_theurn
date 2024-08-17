// import 'package:flutter/material.dart';
// import 'package:ata_app/models/garagePost.dart'; // Update with correct path
// import 'package:ata_app/services/garage_api.dart'; // Update with correct path
// import 'garage_post_detail_page.dart'; // Update with correct path
//
// class GaragePostPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Posts',
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.cyan,
//       ),
//       body: FutureBuilder<List<Garagepost>>(
//         future: GarageApi.fetchGaragePosts(), // Adjust based on your API method
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No posts found'));
//           } else {
//             final posts = snapshot.data!;
//             return ListView.builder(
//               itemCount: posts.length,
//               itemBuilder: (context, index) {
//                 final post = posts[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => GaragePostDetailPage(post: post),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     margin: EdgeInsets.all(8.0),
//                     child: ListTile(
//                       contentPadding: EdgeInsets.all(8.0),
//                       leading: SizedBox(
//                         width: 100, // Set a fixed width for the image
//                         height: 100, // Set a fixed height for the image
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8.0),
//                           child: Image.network(
//                             'https://bunjun.longsoeng.website/assets/images/garageposts/${post.image}',
//                             fit: BoxFit.cover,
//                             loadingBuilder: (BuildContext context, Widget child,
//                                 ImageChunkEvent? loadingProgress) {
//                               if (loadingProgress == null) return child;
//                               return Center(
//                                 child: CircularProgressIndicator(
//                                   value: loadingProgress.expectedTotalBytes !=
//                                       null
//                                       ? loadingProgress.cumulativeBytesLoaded /
//                                       (loadingProgress.expectedTotalBytes ?? 1)
//                                       : null,
//                                 ),
//                               );
//                             },
//                             errorBuilder: (BuildContext context, Object error,
//                                 StackTrace? stackTrace) {
//                               return Center(child: Icon(Icons.error, size: 50));
//                             },
//                           ),
//                         ),
//                       ),
//                       title: Text(post.name),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(post.description),
//                           SizedBox(height: 4.0),
//                           Row(
//                             children: [
//                               Icon(Icons.person, color: Colors.blueAccent),
//                               Text('${post.createByUserId}',
//                                   style:
//                                   TextStyle(fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
