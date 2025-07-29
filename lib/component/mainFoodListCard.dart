// import 'package:flutter/material.dart';


// final List<Map<String, String>> items = [
//     {
//       'image': 'https://via.placeholder.com/150',
//       'title': 'Card Title 1',
//       'subtitle': 'Subtext 1',
//     },
//     {
//       'image': 'https://via.placeholder.com/150',
//       'title': 'Card Title 2',
//       'subtitle': 'Subtext 2',
//     },
//     {
//       'image': 'https://via.placeholder.com/150',
//       'title': 'Card Title 3',
//       'subtitle': 'Subtext 3',
//     },
//     {
//       'image': 'https://via.placeholder.com/150',
//       'title': 'Card Title 4',
//       'subtitle': 'Subtext 4',
//     },
// ];

// class mainFoodListCard extends StatelessWidget {
//   const mainFoodListCard({
//     Key? key,
//     required this.crossAxisCount,
//     required this.items,
//   }) : assert(crossAxisCount == 1 || crossAxisCount == 2),
//     assert(items.length == 4),
//     super(key: key);
//   final int crossAxisCount;
//   final List<items> items;
// }
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("2x2 Card Grid")),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           children: items.map((item) {
//             return Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     blurRadius: 6,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                         const BorderRadius.vertical(top: Radius.circular(12)),
//                     child: Image.network(
//                       item['image']!,
//                       height: 100,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       item['title']!,
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       item['subtitle']!,
//                       style: TextStyle(fontSize: 13, color: Colors.grey[600]),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
