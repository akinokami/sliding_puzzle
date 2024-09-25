import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:sliding_puzzle/models/puzzle_image.dart';
import 'package:sliding_puzzle/services/repositories/images_repository.dart';

const puzzleOptions = <PuzzleImage>[
  PuzzleImage(
    name: 'Numeric',
    assetPath: 'assets/images/numeric-puzzle.png',
    soundPath: '',
  ),
  PuzzleImage(
    name: 'Ronaldo',
    assetPath: 'assets/players/ronaldo.png',
    soundPath: 'assets/sounds/lion.mp3',
  ),
  PuzzleImage(
    name: 'Messi',
    assetPath: 'assets/players/messi.png',
    soundPath: 'assets/sounds/cat.mp3',
  ),
  PuzzleImage(
    name: 'Haaland',
    assetPath: 'assets/players/haaland.png',
    soundPath: 'assets/sounds/dog.mp3',
  ),
  PuzzleImage(
    name: 'Lewandowski',
    assetPath: 'assets/players/lewandowski.png',
    soundPath: 'assets/sounds/fox.mp3',
  ),
  PuzzleImage(
    name: 'Havertz',
    assetPath: 'assets/players/havertz.png',
    soundPath: 'assets/sounds/koala.mp3',
  ),
  PuzzleImage(
    name: 'Foden',
    assetPath: 'assets/players/foden.png',
    soundPath: 'assets/sounds/monkey.mp3',
  ),
  PuzzleImage(
    name: 'De Bryune',
    assetPath: 'assets/players/de_bruyne.png',
    soundPath: 'assets/sounds/mouse.mp3',
  ),
  PuzzleImage(
    name: 'Salah',
    assetPath: 'assets/players/salah.png',
    soundPath: 'assets/sounds/panda.mp3',
  ),
  PuzzleImage(
    name: 'Saka',
    assetPath: 'assets/players/saka.png',
    soundPath: 'assets/sounds/penguin.mp3',
  ),
  PuzzleImage(
    name: 'Heung Min Son',
    assetPath: 'assets/players/son.png',
    soundPath: 'assets/sounds/tiger.mp3',
  ),
];

Future<Image> decodeAsset(ByteData bytes) async {
  return decodeImage(
    bytes.buffer.asUint8List(),
  )!;
}

class SPlitData {
  final Image image;
  final int crossAxisCount;

  SPlitData(this.image, this.crossAxisCount);
}

Future<List<Uint8List>> splitImage(SPlitData data) {
  final image = data.image;
  final crossAxisCount = data.crossAxisCount;
  final int length = (image.width / crossAxisCount).round();
  List<Uint8List> pieceList = [];

  for (int y = 0; y < crossAxisCount; y++) {
    for (int x = 0; x < crossAxisCount; x++) {
      pieceList.add(
        Uint8List.fromList(
          encodePng(
            copyCrop(
              image,
              x * length,
              y * length,
              length,
              length,
            ),
          ),
        ),
      );
    }
  }
  return Future.value(pieceList);
}

class ImagesRepositoryImpl implements ImagesRepository {
  Map<String, Image> cache = {};

  @override
  Future<List<Uint8List>> split(String asset, int crossAxisCount) async {
    late Image image;
    if (cache.containsKey(asset)) {
      image = cache[asset]!;
    } else {
      final bytes = await rootBundle.load(asset);

      /// use compute because theimage package is a pure dart package
      /// so to avoid bad ui performance we do this task in a different
      /// isolate
      image = await compute(decodeAsset, bytes);

      final width = math.min(image.width, image.height);

      /// convert to square
      image = copyResizeCropSquare(image, width);
      cache[asset] = image;
    }

    final pieces = await compute(
      splitImage,
      SPlitData(image, crossAxisCount),
    );

    return pieces;
  }
}
