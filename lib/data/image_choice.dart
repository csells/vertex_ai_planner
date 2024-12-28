enum ImageChoice { location, room }

String imageAssetPath(ImageChoice choice) => switch (choice) {
      ImageChoice.location => 'assets/location.png',
      ImageChoice.room => 'assets/room.png',
    };
