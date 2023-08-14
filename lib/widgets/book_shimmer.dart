import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookShimmer extends StatelessWidget {
  const BookShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.1),
            highlightColor: Colors.grey.withOpacity(0.3),
            child: Container(color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.1),
          highlightColor: Colors.grey.withOpacity(0.3),
          child: Container(
            width: 150,
            height: 25,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.1),
          highlightColor: Colors.grey.withOpacity(0.3),
          child: Container(
            width: 100,
            height: 15,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
