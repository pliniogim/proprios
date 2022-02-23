// import 'package:flutter/material.dart';
//
// import '../../model/movie.dart';
//
// class MovieField extends StatelessWidget {
//   final String field;
//   final String value;
//
//   const MovieField({Key? key, required this.field, required this.value})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text("$field: ",
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 14,
//               fontWeight: FontWeight.w300,
//             )),
//         Expanded(
//           child: Text(value,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w300,
//                 fontSize: 14,
//               )),
//         )
//       ],
//     );
//   }
// }
//
// class HorizontalLine extends StatelessWidget {
//   const HorizontalLine({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Container(
//         height: 0.5,
//         color: Colors.grey,
//       ),
//     );
//   }
// }
//
// class MovieDetailsExtraPosters extends StatelessWidget {
//   final List<String> posters;
//
//   const MovieDetailsExtraPosters({Key? key, required this.posters})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Center(
//             child: Text("More Movie Posters".toUpperCase(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.black26,
//                 )),
//           ),
//           Container(
//             height: 170,
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               separatorBuilder: (context, index) => const SizedBox(
//                 width: 8.0,
//               ),
//               itemCount: posters.length,
//               itemBuilder: (context, index) => ClipRRect(
//                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width / 4,
//                     height: 160,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: NetworkImage(posters[index]),
//                           fit: BoxFit.cover),
//                     ),
//                   )),
//             ),
//           )
//         ]);
//   }
// }
// //New page/route
// class MovieListDetails extends StatelessWidget {
//   final String movieName;
//   final Movie movie;
//
//   const MovieListDetails({Key? key, required this.movieName, required this.movie})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Movies"),
//         backgroundColor: Colors.blueGrey.shade900,
//       ),
//       body: ListView(children: <Widget>[
//         MovieDetailsThumbnail(thumbnail: movie.images[0]),
//         MovieDetailsHeaderWithPoster(movie: movie),
//         MovieDetailsCast(movie: movie)
//       ]),
//     );
//   }
//
// //   body: Center(
// //     child: Container(
// //       child: RaisedButton(
// //         child: Text("${this.movie.country} Back"),
// //         onPressed: () {
// //           Navigator.pop(context);
// //         },
// //       ),
// //     ),
// //   ),
// // );
// //  }
// }
//
// class MovieDetailsThumbnail extends StatelessWidget {
//   final String thumbnail;
//
//   const MovieDetailsThumbnail({Key? key, required this.thumbnail})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
//       Stack(
//         alignment: Alignment.center,
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: 190,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: NetworkImage(thumbnail), fit: BoxFit.cover),
//             ),
//           ),
//           const Icon(
//             Icons.play_circle_outline,
//             size: 100,
//             color: Colors.white,
//           ),
//         ],
//       ),
//       Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter),
//         ),
//         height: 80,
//       ),
//     ]);
//   }
// }
//
// class MovieDetailsHeaderWithPoster extends StatelessWidget {
//   final Movie movie;
//
//   const MovieDetailsHeaderWithPoster({Key? key, required this.movie})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         children: [
//           MoviePoster(poster: movie.images[0].toString()),
//           const SizedBox(
//             width: 16,
//           ),
//           Expanded(child: MovieDetailsHeader(movie: movie))
//         ],
//       ),
//     );
//   }
// }
//
// class MoviePoster extends StatelessWidget {
//   final String poster;
//
//   const MoviePoster({Key? key, required this.poster}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var borderRadius = const BorderRadius.all(Radius.circular(10));
//     return Card(
//       child: ClipRRect(
//           borderRadius: borderRadius,
//           child: Container(
//             width: MediaQuery.of(context).size.width / 4,
//             height: 160,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: NetworkImage(poster), fit: BoxFit.cover)),
//           )),
//     );
//   }
// }
//
// class MovieDetailsHeader extends StatelessWidget {
//   final Movie movie;
//
//   const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text("${movie.year} | ${movie.genre}".toUpperCase(),
//               style: const TextStyle(
//                 fontWeight: FontWeight.w400,
//                 color: Colors.indigo,
//               )),
//           Text(movie.title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 32,
//               )),
//           Text.rich(TextSpan(
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
//               children: <TextSpan>[
//                 TextSpan(text: movie.plot),
//                 const TextSpan(
//                     text: " More...",
//                     style: TextStyle(
//                       color: Colors.indigo,
//                     ))
//               ]))
//         ]);
//   }
// }
//
// class MovieDetailsCast extends StatelessWidget {
//   final Movie movie;
//
//   const MovieDetailsCast({Key? key, required this.movie}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(children: <Widget>[
//           const HorizontalLine(),
//           MovieField(field: "Cast", value: movie.actors),
//           const HorizontalLine(),
//           MovieField(field: "Directors", value: movie.director),
//           const HorizontalLine(),
//           MovieField(field: "Awards", value: movie.awards),
//           const HorizontalLine(),
//           MovieField(field: "Runtime", value: movie.runtime),
//           const HorizontalLine(),
//           MovieField(field: "Country", value: movie.country),
//           const HorizontalLine(),
//           MovieField(field: "ImdbRating", value: movie.imdbRating),
//           const HorizontalLine(),
//           MovieField(field: "ImdbVotes", value: movie.imdbVotes),
//           const HorizontalLine(),
//           MovieDetailsExtraPosters(posters: movie.images)
//         ]));
//   }
// }
//
