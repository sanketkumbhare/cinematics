import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../appstrings/app_constants.dart';

Widget listItems(BuildContext context, String posterPath , String title, String overview) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height *0.25,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(5),
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width *0.27,
                  height: MediaQuery.of(context).size.height *0.20,
                  fit: BoxFit.fill,
                  imageUrl: IMAGE_LOADING_BASE_URL_342 +
                      posterPath.toString(),
                  placeholder: (context, url) => const Icon(Icons.image),
                  errorWidget: (context, url, error) => const Icon(Icons.image),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10,top: 20),
              width: MediaQuery.of(context).size.width * 0.58,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title == "null"? "No Name":title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),maxLines: 2,overflow: TextOverflow.ellipsis),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(overview,overflow: TextOverflow.ellipsis,maxLines: 6,),
                  )
                ],
              ),
            )
          ],
        ),
      ));
}

// SizedBox(
// width: MediaQuery.of(context).size.width,
// height: 200,
// child: Card(
// semanticContainer: true,
// clipBehavior: Clip.antiAliasWithSaveLayer,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10.0),
// ),
// elevation: 5,
// margin: const EdgeInsets.all(10),
// child: Row(
// children: [
// Container(
// height: double.infinity,
// alignment: Alignment.topLeft, // This is needed
// child: CachedNetworkImage(imageUrl: '',
//
// )
// ),
// Flexible(
// child: Container(
// margin: EdgeInsets.only(left: 10),
// child: Text("${result.overview}")
// ),
// )
// ],
// ),
// ),
// );
