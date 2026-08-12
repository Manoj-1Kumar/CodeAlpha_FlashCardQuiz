import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/flashcard.dart';
import '../widgets/flashcard_widget.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Flashcard> cards = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  Future<void> loadCards() async {
    cards = await DatabaseHelper.instance.getCards();

    setState(() {});
  }

  void nextCard() {
    if (cards.isEmpty) return;

    setState(() {
      currentIndex = (currentIndex + 1) % cards.length;
    });
  }

  void previousCard() {
    if (cards.isEmpty) return;

    setState(() {
      currentIndex =
          (currentIndex - 1 + cards.length) % cards.length;
    });
  }

  Future<void> deleteCurrentCard() async {
  if (cards.isEmpty) return;

  await DatabaseHelper.instance.deleteCard(cards[currentIndex].id!);

  await loadCards();

  if (cards.isNotEmpty && currentIndex >= cards.length) {
    setState(() {
      currentIndex = cards.length - 1;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flashcard Quiz"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditScreen(),
            ),
          );

          loadCards();
        },
      ),

      body: cards.isEmpty
          ? const Center(
              child: Text(
                "No Flashcards Yet\nClick + to Add One",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  Text(
  "Card ${currentIndex + 1} of ${cards.length}",
  style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 10),

LinearProgressIndicator(
  value: (currentIndex + 1) / cards.length,
  minHeight: 8,
  borderRadius: BorderRadius.circular(20),
),

const SizedBox(height: 20),

                  Expanded(
                    child: FlashcardWidget(
                      card: cards[currentIndex],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      ElevatedButton.icon(
                        onPressed: previousCard,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Previous"),
                      ),

                      ElevatedButton.icon(
                        onPressed: nextCard,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Next"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,

                    children: [

                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),

                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AddEditScreen(
                                flashcard:
                                    cards[currentIndex],
                              ),
                            ),
                          );

                          loadCards();
                        },

                        icon: const Icon(Icons.edit),

                        label: const Text("Edit"),
                      ),

                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),

                        onPressed: deleteCurrentCard,

                        icon: const Icon(Icons.delete),

                        label: const Text("Delete"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}