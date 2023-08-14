import 'package:book_app/data/source/shpref/my_shared_pref.dart';
import 'package:book_app/pages/home/home_screen.dart';
import 'package:book_app/widgets/pege_view_item.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final controller = PageController();
  final pref = MySharedPref();
  var index = 0.0;
  var titles = <String>[
    "Read your e-books",
    "Order your books",
    "Now you can listen audio books",
  ];
  var descs = <String>[
    "Contrary You can buy any books online. we will deliver the book within 2 days in tashkent 3 days within Uzbekistan",
    "Contrary You can buy any books online. we will deliver the book within 2 days in tashkent 3 days within Uzbekistan",
    "We have vide range of audio books that you can enjoy listening books anytime, anywhere",
  ];

  @override
  void initState() {
    controller.addListener(() {
      index = controller.page!;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigateNextScreen() {
    pref.setBool(false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            allowImplicitScrolling: true,
            controller: controller,
            itemCount: titles.length,
            itemBuilder: (context, index) {
              return OnBoardingItem(
                  img: "assets/icons/intro${index + 1}.svg",
                  text1: titles[index],
                  text2: descs[index]);
            },
          ),
          Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (index.round() < 2) {
                          navigateNextScreen();
                        }
                      },
                      child: Text(
                        (index.round() < 2) ? "Skip" : "       ",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                      child: ListView.separated(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (_, i) {
                          return Container(
                            width: 16,
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.black),
                              color: i == index.round()
                                  ? const Color(0xFF9098B1)
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (index.round() == 2) {
                          navigateNextScreen();
                          return;
                        }
                        controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 8),
                        decoration: ShapeDecoration(
                          color: Color(0xFFD45555),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 24)
            ],
          ),
        ],
      ),
    );
  }
}
