import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WidgetBookItem extends StatelessWidget {
  final String name;
  final String author;
  final String image;
  final Function()? onTap;

  const WidgetBookItem({
    super.key,
    this.name = "",
    this.author = "",
    this.image = "",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: CachedNetworkImage(imageUrl: image)),
                Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  author,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ));
  }
}
