
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../appstrings/AppConstants.dart';
import '../model/movieResponse/Results.dart';

Widget listItemPosterMovies(BuildContext context, String posterPath){
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.33,
    child: Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: IMAGE_LOADING_BASE_URL_342 + posterPath.toString(),
            placeholder: (context, url) => const Icon(Icons.image),
            errorWidget: (context, url, error) => const Icon(Icons.image),
          )
          // Image.network(
          //   IMAGE_LOADING_BASE_URL_342 + value.posterPath.toString(),
          //   fit: BoxFit.fill,
          // ),
        ],
      ),
    ),
  );
}

//Image(image: NetworkImage(IMAGE_LOADING_BASE_URL_342 + imageUrls),fit: BoxFit.cover,)