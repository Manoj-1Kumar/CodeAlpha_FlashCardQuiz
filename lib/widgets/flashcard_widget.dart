import 'dart:math';

import 'package:flutter/material.dart';

import '../models/flashcard.dart';

class FlashcardWidget extends StatefulWidget {
  final Flashcard card;

  const FlashcardWidget({
    super.key,
    required this.card,
  });

  @override
  State<FlashcardWidget> createState() =>
      _FlashcardWidgetState();
}

class _FlashcardWidgetState
    extends State<FlashcardWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  bool isFront = true;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void didUpdateWidget(covariant FlashcardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    controller.reset();

    isFront = true;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void flipCard() {

    if (isFront) {
      controller.forward();
    } else {
      controller.reverse();
    }

    isFront = !isFront;
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: flipCard,

      child: AnimatedBuilder(

        animation: controller,

        builder: (_, child) {

          double angle = controller.value * pi;

          bool showFront = angle <= pi / 2;

          return Transform(

            alignment: Alignment.center,

            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),

            child: Container(

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                  ),

                ],
              ),

              padding: const EdgeInsets.all(25),

              child: Center(

                child: showFront

                    ? Column(

                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          const Icon(
                            Icons.help,
                            size: 60,
                            color: Colors.indigo,
                          ),

                          const SizedBox(height: 20),

                          Text(

                            widget.card.question,

                            textAlign:
                                TextAlign.center,

                            style: const TextStyle(

                              fontSize: 24,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 30),

                          const Text(
                            "Tap to Flip",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),

                        ],
                      )

                    : Transform(

                        alignment: Alignment.center,

                        transform:
                            Matrix4.rotationY(pi),

                        child: Column(

                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [

                            const Icon(
                              Icons.lightbulb,
                              size: 60,
                              color: Colors.orange,
                            ),

                            const SizedBox(height: 20),

                            Text(

                              widget.card.answer,

                              textAlign:
                                  TextAlign.center,

                              style: const TextStyle(

                                fontSize: 22,

                                fontWeight:
                                    FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 30),

                            const Text(
                              "Tap to Flip Back",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),

                          ],
                        ),

                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}