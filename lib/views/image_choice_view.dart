import 'package:flutter/material.dart';

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
          GestureDetector(
            onTap: () => onChanged(choice),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                _imageAssetPath(choice),
                fit: BoxFit.cover,
              ),
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
                checkColor: Colors.blue[900],
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