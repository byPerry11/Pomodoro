import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

enum MusicCategory { none, work, breakTime }

class MusicTrack {
  final String name;
  final String path;
  final MusicCategory category;

  const MusicTrack({
    required this.name,
    required this.path,
    required this.category,
  });
}

@lazySingleton
class MusicService extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Available tracks
  final List<MusicTrack> _tracks = [
    const MusicTrack(
      name: 'Lluvia y Tormenta',
      path: 'sounds/Work/Rain and Thunderstorm.m4a',
      category: MusicCategory.work,
    ),
    const MusicTrack(
      name: 'Lofi de Descanso',
      path: 'sounds/Break/Break Lofi.mp3',
      category: MusicCategory.breakTime,
    ),
  ];

  MusicTrack? _selectedTrack;
  bool _isPlaying = false;
  final double _volume = 0.5;

  List<MusicTrack> get tracks => _tracks;
  MusicTrack? get selectedTrack => _selectedTrack;
  bool get isPlaying => _isPlaying;

  MusicService() {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  void selectTrack(MusicTrack? track) {
    _selectedTrack = track;
    // Only stop if currently playing and track is set to null
    if (_isPlaying && track == null) {
      stop();
    }
    notifyListeners();
  }

  // Helper to filter by category
  List<MusicTrack> getTracksByCategory(MusicCategory category) {
    return _tracks.where((t) => t.category == category).toList();
  }

  Future<void> play() async {
    if (_selectedTrack == null) return;

    try {
      await _audioPlayer.play(AssetSource(_selectedTrack!.path));
      await _audioPlayer.setVolume(_volume);
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print('Error playing music: $e');
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() {
    if (_selectedTrack != null) {
      play();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
