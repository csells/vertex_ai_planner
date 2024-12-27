import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';

import '../buttons/hollow_button.dart';
import '../buttons/solid_button.dart';
import '../data/plan_repository.dart';
import 'image_choice_view.dart';

class PlannerView extends StatefulWidget {
  const PlannerView({required this.planRepository, super.key});
  final PlanRepository planRepository;

  @override
  State<PlannerView> createState() => _PlannerViewState();
}

class _PlannerViewState extends State<PlannerView> {
  final _model = FirebaseVertexAI.instance.generativeModel(
    model: 'gemini-1.5-flash-002',
    systemInstruction: Content.text('TODO'),
  );

  var _selectedImageChoice = ImageChoice.location;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectImageChoice(ImageChoice.location);
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image selection row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // First image (location)
                Expanded(
                  child: ImageChoiceView(
                    choice: ImageChoice.location,
                    groupChoice: _selectedImageChoice,
                    onChanged: _selectImageChoice,
                  ),
                ),
                const SizedBox(width: 24),
                // Second image (Room)
                Expanded(
                  child: ImageChoiceView(
                    choice: ImageChoice.room,
                    groupChoice: _selectedImageChoice,
                    onChanged: _selectImageChoice,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Prompt input section with Go button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Add a prompt*',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SolidButton(
                  onPressed: _goPressed,
                  icon: Image.asset(
                    'assets/Spark_Gradient.png',
                    fit: BoxFit.cover,
                    height: 16,
                  ),
                  label: 'Go',
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Helper text
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: '*Update the prompt to generate a new list, like:\n',
                  ),
                  TextSpan(
                    text: 'Help me plan a trip to this location',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Save and Reset buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save button
                SolidButton(
                  onPressed: _savePressed,
                  label: 'Save',
                ),
                const SizedBox(width: 16),
                // Reset button
                HollowButton(
                  onPressed: _resetPressed,
                  label: 'Reset',
                ),
              ],
            ),
          ],
        ),
      );

  void _selectImageChoice(ImageChoice value) => setState(() {
        _selectedImageChoice = value;
        _controller.text = _promptFor(value);
      });

  String _promptFor(ImageChoice value) => switch (value) {
        ImageChoice.location =>
          'You are a travel expert planning a trip here for 5 people including '
              'one toddler and my mom who is turning 50',
        ImageChoice.room => 'You are an organization expert transforming this '
            'place to be enjoyed by a child and a toddler who love superheroes',
      };

  void _goPressed() {
    debugPrint('Go button pressed');
  }

  void _savePressed() {
    debugPrint('Save button pressed');
  }

  void _resetPressed() {
    debugPrint('Reset button pressed');
  }
}
