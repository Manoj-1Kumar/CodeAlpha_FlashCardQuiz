import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/flashcard.dart';

class AddEditScreen extends StatefulWidget {
  final Flashcard? flashcard;

  const AddEditScreen({
    super.key,
    this.flashcard,
  });

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController questionController;
  late TextEditingController answerController;

  @override
  void initState() {
    super.initState();

    questionController = TextEditingController(
      text: widget.flashcard?.question ?? '',
    );

    answerController = TextEditingController(
      text: widget.flashcard?.answer ?? '',
    );
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  Future<void> saveCard() async {
    if (!_formKey.currentState!.validate()) return;

    final card = Flashcard(
      id: widget.flashcard?.id,
      question: questionController.text.trim(),
      answer: answerController.text.trim(),
    );

    if (widget.flashcard == null) {
      await DatabaseHelper.instance.insertCard(card);
    } else {
      await DatabaseHelper.instance.updateCard(card);
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.flashcard != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Flashcard" : "Add Flashcard",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              TextFormField(
                controller: questionController,

                decoration: const InputDecoration(
                  labelText: "Question",
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a question";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: answerController,

                maxLines: 4,

                decoration: const InputDecoration(
                  labelText: "Answer",
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter an answer";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: saveCard,

                  child: Text(
                    isEditing ? "Update Card" : "Save Card",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}