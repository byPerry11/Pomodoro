import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_app/l10n/app_localizations.dart';
import '../providers/music_service.dart';

class MusicSelectionDialog extends StatefulWidget {
  const MusicSelectionDialog({super.key});

  @override
  State<MusicSelectionDialog> createState() => _MusicSelectionDialogState();
}

class _MusicSelectionDialogState extends State<MusicSelectionDialog> {
  MusicCategory _selectedCategory = MusicCategory.work;

  @override
  void initState() {
    super.initState();
    // Initialize category based on current selection
    final musicService = context.read<MusicService>();
    if (musicService.selectedTrack != null) {
      _selectedCategory = musicService.selectedTrack!.category;
    } else {
      _selectedCategory = MusicCategory.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text(
        l10n.musicDialogTitle,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: 'Funnel Sans',
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Consumer<MusicService>(
          builder: (context, musicService, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Category Selector
                SegmentedButton<MusicCategory>(
                  segments: [
                    ButtonSegment(
                      value: MusicCategory.none,
                      label: Text(l10n.musicNone),
                    ),
                    ButtonSegment(
                      value: MusicCategory.work,
                      label: Text(l10n.musicWork),
                    ),
                    ButtonSegment(
                      value: MusicCategory.breakTime,
                      label: Text(l10n.musicBreak),
                    ),
                  ],
                  selected: {_selectedCategory},
                  onSelectionChanged: (Set<MusicCategory> newSelection) {
                    setState(() {
                      _selectedCategory = newSelection.first;
                    });
                    if (_selectedCategory == MusicCategory.none) {
                      musicService.selectTrack(null);
                    }
                  },
                  showSelectedIcon: false,
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const SizedBox(height: 24),

                // Track List
                if (_selectedCategory == MusicCategory.none)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(
                      l10n.musicNoneDesc,
                      style: TextStyle(
                        color: colorScheme.secondary,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: musicService
                          .getTracksByCategory(_selectedCategory)
                          .map((track) {
                            final isSelected =
                                musicService.selectedTrack == track;
                            return _buildMusicOption(
                              context,
                              track,
                              track.name,
                              isSelected,
                              musicService,
                            );
                          })
                          .toList(),
                    ),
                  ),

                if (_selectedCategory != MusicCategory.none &&
                    musicService.getTracksByCategory(_selectedCategory).isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      l10n.musicNoSounds,
                      style: TextStyle(color: colorScheme.secondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            l10n.doneButton,
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMusicOption(
    BuildContext context,
    MusicTrack track,
    String title,
    bool isSelected,
    MusicService musicService,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.outline.withValues(alpha: 0.3),
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: ListTile(
        onTap: () {
          musicService.selectTrack(track);
        },
        leading: Icon(
          isSelected ? Icons.volume_up : Icons.music_note_outlined,
          color: isSelected ? colorScheme.primary : colorScheme.secondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: colorScheme.primary, size: 20)
            : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      ),
    );
  }
}
