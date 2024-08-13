import 'package:just_audio/just_audio.dart';

/// This class extends the just_audio's AudioPlayer class to enable GapLessLoop
/// This class should not be used directly and hence the '_' in front of it
/// public members:
/// - playGapLessLoop: function to implement gap-less audio loop
class _GapLessAudioPlayer extends AudioPlayer {
  /// This function enables to playGapLessLoop and ,extends original AudioPlayer
  /// These codes are inspired from just_audio docs with example of
  /// gap-less playlist
  /// link: https://pub.dev/packages/just_audio#working-with-gapless-playlists
  ///
  /// params:
  ///  - list of files to be played
  ///
  /// Todo:
  /// - enable adding/removing file to playlist
  /// - make playlist class property instead of just a parameter
  /// - separate creation and playing of the playlist
  Future<void> playGapLessLoop(List<String> playListFiles) async {
    List<AudioSource> audioFiles =
        playListFiles.map((file) => AudioSource.asset(file)).toList();

    final ConcatenatingAudioSource playList = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: audioFiles);

    await setAudioSource(playList);
    await setLoopMode(LoopMode.all);
    await setVolume(1.0);
    await play();
  }
}

/// This is a simply manager class to implement the audio
/// This class should be used to implement audio in game
/// private properties
///  - _gapLessPlayer: an instance of GapLessAudioPlayer
///  - _player: an instance of AudioPlayer
///
/// public members:
/// - playGapLessLoop: uses playGapLessLoop from GapLessAudioPlayer
/// - stopGapLessLoop: stops GapLessAudioPlayer
/// - playShortAudio: plays other short burst of sounds and stops them
class Audio {
  final _gapLessPlayer = _GapLessAudioPlayer();
  final _player = AudioPlayer();

  Future<void> playGapLessLoop(List<String> playListFiles) async {
    await _gapLessPlayer.playGapLessLoop(playListFiles);
  }

  Future<void> stopGapLessLoop() async {
    await _gapLessPlayer.stop();
  }

  Future<void> playShortAudio(String audioFile) async {
    await _player.setAudioSource(AudioSource.asset(audioFile));
    await _player.setVolume(1.0);
    await _player.play();
    await _player.stop();
  }
}
