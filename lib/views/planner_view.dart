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
            ),
            const SizedBox(height: 8),

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
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/Spark_Gradient.png',
                    fit: BoxFit.cover,
                    height: 16,
                  ),
                  label: const Text('Go'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    foregroundColor: Colors.blue[900],
                  ),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              _imageAssetPath(choice),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 24,
            left: 24,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Checkbox(
                value: choice == groupChoice,
                onChanged: (value) => onChanged(choice),
                fillColor: WidgetStateProperty.all(Colors.white),
                checkColor: Colors.black,
                side: BorderSide.none,
              ),
            ),
          ),
        ],
      );

  String _imageAssetPath(ImageChoice choice) => switch (choice) {
        ImageChoice.location => 'assets/location.png',
        ImageChoice.room => 'assets/room.png',
      };
}
