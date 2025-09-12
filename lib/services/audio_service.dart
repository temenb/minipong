import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _backgroundPlayer = AudioPlayer();

  Future<void> playPing(int playerNum) async {
    if (playerNum == 0) {
      await _audioPlayer.play(AssetSource('audio/goal1.mp3'));
    } else if (playerNum == 1) {
      await _audioPlayer.play(AssetSource('audio/goal2.mp3'));
    }
  }

  Future<void> playUndo() async {
    await _audioPlayer.play(AssetSource('audio/undo-goal.mp3'));
  }

  Future<void> playBackground() async {
    await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
    await _backgroundPlayer.play(AssetSource('audio/background.mp3'));
  }

  Future<void> stopBackground() async {
    await _backgroundPlayer.stop();
  }
}
