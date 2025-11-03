import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class PoolNumberResult extends StatelessWidget {
  final String resultNo;
  final bool isPlaying;
  final Size size;
  const PoolNumberResult({super.key, required this.resultNo, required this.isPlaying, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width,
        height: size.height,
        color: Colors.transparent,
        child: isPlaying
            ? BallAnimationWidget(
                size: size,
              )
            : Center(
                child: Image.asset(
                  'assets/images/$resultNo.png',
                  width: 60,
                  height: 60,
                ),
              ));
  }
}

class BallAnimationWidget extends StatefulWidget {
  final Size size;
  final int runMiliSec;
  const BallAnimationWidget({super.key, required this.size, this.runMiliSec = 1000});

  @override
  State<BallAnimationWidget> createState() => _BallAnimationWidgetState();
}

class _BallAnimationWidgetState extends State<BallAnimationWidget> with TickerProviderStateMixin {
  List<Widget> balls = [];
  List<AnimationController> controllers = [];
  List<Animation<Offset>> animations = [];
  Random random = Random();
  Timer? resetTimer;
  @override
  void initState() {
    super.initState();

    runPoolBallAnimation();
    // Start the reset timer
    resetTimer = Timer.periodic(Duration(milliseconds: widget.runMiliSec * 2), (v) {
      resetAnimation();
    });
  }

  void resetAnimation() {
    
    // Stop and dispose existing animations and controllers
    for (var controller in controllers) {
      controller.dispose();
    }

    // Clear lists
    balls.clear();
    controllers.clear();
    animations.clear();

    // Run animation again
    runPoolBallAnimation();

    setState(() {});
  }


  runPoolBallAnimation() {
    // Initialize 8 balls
    for (int i = 1; i <= 8; i++) {
      // Random start and end positions
      double startX = random.nextDouble() * widget.size.width;
      double startY = random.nextDouble() * widget.size.height;
      double endX = random.nextDouble() * widget.size.width;
      double endY = random.nextDouble() * widget.size.height;

      // Create AnimationController for each ball
      AnimationController controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.runMiliSec),
      );

      // Create Tween and Animation for each ball
      Tween<Offset> tween = Tween(
        begin: Offset(startX, startY),
        end: Offset(endX, endY),
      );
      Animation<Offset> animation = tween.animate(controller);

      controllers.add(controller);
      animations.add(animation);

      // Add ball to the list
      balls.add(
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Positioned(
              left: animation.value.dx,
              top: animation.value.dy,
              child: child!,
            );
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/$i.png'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );

      controller.addListener(() {
        if (controller.status == AnimationStatus.completed) {
          controller.reverse(); // Reverse the animation when it's completed
        } else if (controller.status == AnimationStatus.dismissed) {
          controller.forward(); // Forward the animation when it's dismissed
        }
      });

      controller.forward(); // Start the animation
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        children: balls,
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers and timer to prevent memory leaks
    for (var controller in controllers) {
      controller.dispose();
    }
    resetTimer?.cancel(); // Cancel the timer if it's not null
    super.dispose();
  }
}