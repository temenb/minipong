import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playPing(int playerNum) async {
    if (playerNum == 1) {
      await _audioPlayer.play(AssetSource('audio/ping1.mp3'));
    } else if (playerNum == 2) {
      await _audioPlayer.play(AssetSource('audio/ping2.mp3'));
    }
  }
}

