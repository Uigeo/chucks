import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimatedCount extends AnimatedWidget {
  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.3, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0.0, end: 100.0);

  AnimatedCount({Key key, Animation<double> animation})
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
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white12
                ),
              )
              ,Container(
                height: 20.0,
                width: 20.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                ),
              ),
            ],

          ),
        )

    );



  }
}

class CountDown extends StatefulWidget {
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> with SingleTickerProviderStateMixin {
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
//      } else if (status == AnimationStatus.dismissed) {
//        controller.forward();
//      }
    });

    controller.forward();
  }

  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedCount(animation: animation),
        Text( countnum.toString(), style: TextStyle( color: Colors.white, fontFamily: 'SairaL' , fontSize: 80.0), ),
      ],
    );


  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}