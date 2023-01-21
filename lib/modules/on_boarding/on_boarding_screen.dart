import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../login/shop_login_screen.dart';

class BoardingModel{

  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/images/shop_open.jpg',
        title: 'Screen 1 title',
        body: 'Screen 1 body'),
    BoardingModel(
        image: 'assets/images/sale.jpg',
        title: 'Screen 2 title',
        body: 'Screen 2 body'),
    BoardingModel(
        image: 'assets/images/market.jpg',
        title: 'Screen 3 title',
        body: 'Screen 3 body'),
  ];

  var boardController = PageController();
  bool  isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: const Text('skip',
              style: TextStyle(
                fontSize: 20.0,
              ),),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                itemBuilder:(context, index) => buildOnBoardItem(boarding[index]),
                itemCount: 3,
                onPageChanged: (int index){
                  if(index==boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                      print('last');
                    }
                  else{
                    setState(() {
                      isLast=false;
                    });
                    print('not last');
                  }
                },
                physics: BouncingScrollPhysics(),
              ),
            ),
            SizedBox(height: 80.0,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect:  const WormEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      spacing: 8,
                    ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed:(){
                    if(isLast)
                      {
                        submit();
                      }
                    else{
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child:Icon(Icons.arrow_forward) ,),
              ],
            ),
            SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardItem(BoardingModel model)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}',
            ),
            height: 120.0,
          ),
        ),
        SizedBox(height: 20.0,),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.0,),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 16.0,

          ),
        ),
        SizedBox(height: 20.0,),
      ],
    );
  }

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true)
        .then((value) {
      navigateAndFinish(context,ShopLoginScreen());
    }
    );

  }
}
