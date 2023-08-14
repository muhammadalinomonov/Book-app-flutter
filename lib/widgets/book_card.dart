import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {

  final String title;
  final String author;
  final String image;
  const BookCard({Key? key, required this.title, required this.author, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                )
            )
        ),
        const SizedBox(height: 10),
        SizedBox(
          child: Text(
            title,
            maxLines: 1,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                overflow: TextOverflow.ellipsis),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.4,
          child: Text(
            author,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 13,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }
}
