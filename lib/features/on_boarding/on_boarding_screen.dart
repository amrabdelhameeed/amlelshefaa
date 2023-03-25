import '../../core/constants/strings.dart';
import '../../core/utils/shared_pref_helper.dart';
import '../../core/widgets/components.dart';
import 'sign_in_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  var loginColor = const Color(0xffefe9c2);
  double shadow = 0;

  List<BoardingModel> boarding = [
    BoardingModel(image: 'assets/pictures/on_boarding/on_boarding_1.png', title: 'تكلم مع اكثر من +10 دكتور في نوع الضمور الخاص بك', body: 'دكاترة علي اعلي مستوي في مصر'),
    BoardingModel(image: 'assets/pictures/on_boarding/on_boarding_2.png', title: 'تكلم مع جميع المرضي', body: 'اجعل رسائلك بناءة'),
    BoardingModel(image: 'assets/pictures/on_boarding/on_boarding_3.png', title: 'ابدأ الان ', body: 'هيا بنا'),
  ];

  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffefe9c2),
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                goToSignIn();
              },
              child: Text(
                'SKIP',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: const Color(0xfff5b53f),
                      decoration: TextDecoration.underline,
                    ),
              ))
        ],
        elevation: 0,
        backgroundColor: const Color(0xffefe9c2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  setState(() {
                    if (index == boarding.length - 1) {
                      isLast = true;
                    } else {
                      isLast = false;
                    }
                  });
                },
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Color(0xfff5b53f),
                    spacing: 10.0,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 3,
                  ),
                  controller: boardController,
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  tooltip: 'next page',
                  elevation: 0,
                  mini: true,
                  backgroundColor: const Color(0xfff5b53f),
                  child: const Icon(
                    Icons.navigate_next,
                  ),
                  onPressed: () {
                    if (isLast) {
                      goToSignIn();
                    } else {
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 700,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                model.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xfff5b53f)),
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.body,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                      color: const Color(0xfff5b53f),
                      fontWeight: FontWeight.w900,
                    ),
                textAlign: TextAlign.center,
              ),
              Expanded(child: Image(image: AssetImage(model.image))),
            ],
          ),
        ),
      );

  Future<void> goToSignIn() async {
    await SharedPrefHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, signInUpScreen);
      }
    });
  }
}
