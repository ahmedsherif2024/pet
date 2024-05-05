import 'package:flutter/material.dart';
import 'package:pharmacy_talk/onboarding_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {

  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage? getStarted() :  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () =>
                  pageController.jumpToPage(controller.items.length -1),
              child: Text(
                "Skip",
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index) => pageController.animateToPage(index,
                  duration: Duration(milliseconds: 600), curve: Curves.easeIn),
              effect: WormEffect(
                radius: 10,
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: Colors.purple,
              ),
            ),
            TextButton(
              onPressed: () => pageController.nextPage(
                  duration: Duration(microseconds: 600), curve: Curves.easeIn),
              child: Text(
                "Next",
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index)=> setState(()=> isLastPage = controller.items.length-1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, i) {
              return Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      controller.items[i].image,
                      height: 300,
                    ),
                    Text(
                      controller.items[i].title,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      controller.items[i].description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    // Container(
                    //   height: 60,
                    //   margin: EdgeInsets.all(40),
                    //   width: double.infinity,
                    //   child: MaterialButton(
                    //     onPressed: (){},
                    //     color: Theme.of(context).primaryColor,
                    //     textColor: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     child: Text(
                    //       "Next",
                    //     ) ,
                    //   ) ,
                    // ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  //Get Started
  Widget getStarted (){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.purple,
      ),
      width: MediaQuery.of(context).size.width * .9,
      child: TextButton(
          onPressed: ()
          {
            Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
          },
          child: Text("Get Started", style: TextStyle(
            color: Colors.white,
          ),)),
    );
  }
}
