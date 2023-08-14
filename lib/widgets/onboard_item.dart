import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardItem extends StatelessWidget {
  final String img;
  final String text1;
  final String text2;
  const OnBoardItem({Key? key, required this.img, required this.text1, required this.text2,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.25,),
            SizedBox(
                height: 280,
                width: 280,
                child: SvgPicture.asset(img)),
            const SizedBox(height: 30,),
            Text(
              text1,
              style: GoogleFonts.montserrat().copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 30,),
            SizedBox(
              child: Center(
                child: Text(
                  text2,
                  style: GoogleFonts.roboto().copyWith(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.grey.shade900
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        )
    );
  }
}
