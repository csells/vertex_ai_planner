import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';

import '../data/plan_repository.dart';

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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image selection row
            Expanded(
              child: Row(
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
                  const SizedBox(width: 16),
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
            ),
            const SizedBox(height: 8),

            // Prompt input section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add a prompt*',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Helper text
            const Text(
              'Update the prompt to generate a new list, like:\n'
              'Help me plan a trip to this location',
              style: TextStyle(color: Colors.grey),
            ),

            // Go button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.auto_awesome, size: 16),
                label: const Text('Go'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[100],
                  foregroundColor: Colors.blue[900],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Save and Reset buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Reset button
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.purple[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.purple[700]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.purple[700],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
}

enum ImageChoice { location, room }

class ImageChoiceView extends StatelessWidget {
  const ImageChoiceView({
    required this.choice,
    required this.groupChoice,
    required this.onChanged,
    super.key,
  });

  final ImageChoice choice;
  final ImageChoice groupChoice;
  final void Function(ImageChoice choice) onChanged;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Image.asset(
            _imageAssetPath(choice),
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Radio<ImageChoice>(
              value: choice,
              groupValue: groupChoice,
              onChanged: (value) => onChanged(value!),
              fillColor: WidgetStateProperty.all(Colors.white),
            ),
          ),
        ],
      );

  String _imageAssetPath(ImageChoice choice) => switch (choice) {
        ImageChoice.location => 'assets/location.png',
        ImageChoice.room => 'assets/room.png',
      };
}
