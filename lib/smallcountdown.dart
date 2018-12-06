import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SmallAnimatedCount extends AnimatedWidget {


  SmallAnimatedCount({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
        child: RotationTransition(
          turns: animation,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white12
                ),
              )
              ,Container(
                height: 10.0,
                width: 10.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepOrangeAccent
                ),
              ),
            ],

          ),
        )

    );



  }
}

class SmallCountDown extends StatefulWidget {
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<SmallCountDown> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  int countnum = 15;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        setState(() {

          countnum -=1;
          if(countnum == 0) dispose();
        });
        controller.forward();
      }
    });
    controller.forward();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SmallAnimatedCount(animation: animation),
          Text( countnum.toString(), style: TextStyle( color: Colors.deepOrangeAccent, fontFamily: 'SairaL' , fontSize: 50.0), ),
        ],
      ),
    );


  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}