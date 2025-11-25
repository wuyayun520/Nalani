import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import '../theme/app_theme.dart';

class DubbingTabPage extends StatefulWidget {
  const DubbingTabPage({super.key});

  @override
  State<DubbingTabPage> createState() => _DubbingTabPageState();
}

class _DubbingTabPageState extends State<DubbingTabPage> {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  
  bool _isRecording = false;
  bool _hasRecording = false;
  bool _isPlaying = false;
  String? _recordingPath;
  int _currentTextIndex = 0;
  Duration _recordingDuration = Duration.zero;
  Timer? _recordingTimer;

  // Sample dubbing scripts - original creative content
  final List<Map<String, String>> _dubbingScripts = [
    {
      'text': 'Do you want to know what I think? I don\'t find it funny. I think my life is a comedy. The reason you\'re angry is simply that I can see things more lightly than you and think that dying doesn\'t matter. If it were me who died, it would be even funnier for you, right?',
      'source': '《Long holiday》',
    },
    {
      'text': 'The world is not in your books and maps. It\'s out there. You can\'t just give up on the people you love. Sometimes the smallest thing can change your life forever.',
      'source': '《Adventure Tales》',
    },
    {
      'text': 'Every moment of our lives, we are making choices. Some are small, some are big. But each one shapes who we become. That\'s the beauty and terror of being alive.',
      'source': '《Life Reflections》',
    },
    {
      'text': 'Stars cannot shine without darkness. When everything seems hopeless, look up at the night sky and remember that even the smallest light can guide someone home.',
      'source': '《Night Whispers》',
    },
    {
      'text': 'They say time heals all wounds, but I think that\'s not quite right. Time doesn\'t heal; it teaches us how to live with what we cannot change.',
      'source': '《Wisdom of Ages》',
    },
  ];

  @override
  void dispose() {
    _recorder.dispose();
    _player.dispose();
    _recordingTimer?.cancel();
    super.dispose();
  }

  void _changeText() {
    setState(() {
      _currentTextIndex = (_currentTextIndex + 1) % _dubbingScripts.length;
    });
  }

  Future<void> _startRecording() async {
    try {
      if (await _recorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final path = '${directory.path}/dubbing_${DateTime.now().millisecondsSinceEpoch}.m4a';
        
        await _recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: path,
        );
        
        setState(() {
          _isRecording = true;
          _recordingPath = path;
          _recordingDuration = Duration.zero;
        });

        _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _recordingDuration += const Duration(seconds: 1);
          });
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to start recording: $e')),
        );
      }
    }
  }

  Future<void> _stopRecording() async {
    try {
      _recordingTimer?.cancel();
      final path = await _recorder.stop();
      
      setState(() {
        _isRecording = false;
        _hasRecording = path != null;
        if (path != null) {
          _recordingPath = path;
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to stop recording: $e')),
        );
      }
    }
  }

  Future<void> _playRecording() async {
    if (_recordingPath == null) return;

    try {
      if (_isPlaying) {
        await _player.pause();
        setState(() {
          _isPlaying = false;
        });
      } else {
        await _player.setFilePath(_recordingPath!);
        _player.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed) {
            setState(() {
              _isPlaying = false;
            });
          }
        });
        await _player.play();
        setState(() {
          _isPlaying = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to play recording: $e')),
        );
      }
    }
  }

  void _deleteRecording() {
    setState(() {
      _hasRecording = false;
      _recordingPath = null;
      _recordingDuration = Duration.zero;
    });
    if (_recordingPath != null) {
      try {
        File(_recordingPath!).deleteSync();
      } catch (_) {}
    }
  }

  void _publishRecording() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Publish'),
        content: const Text('Your dubbing has been published successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Color(0xFFFFF9E6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // 顶部导航栏
            _buildHeader(),
            // 主要内容
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // 文本展示卡片
                    _buildTextCard(),
                    const SizedBox(height: 20),
                    // 换一个按钮
                    _buildChangeButton(),
                    const SizedBox(height: 40),
                    // 录音状态显示
                    if (_isRecording) _buildRecordingStatus(),
                    // 已录制内容
                    if (_hasRecording && !_isRecording) _buildRecordedContent(),
                    const SizedBox(height: 20),
                    // 录音按钮
                    _buildRecordButton(),
                    const SizedBox(height: 12),
                    Text(
                      _isRecording ? 'Tap to stop' : 'Click to record~',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          const Text(
            'Record audio',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Color(0xFF333333),
            ),
          ),
          GestureDetector(
            onTap: _hasRecording ? _publishRecording : null,
            child: Text(
              'Done',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _hasRecording ? AppTheme.primaryColor : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextCard() {
    final script = _dubbingScripts[_currentTextIndex];
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3D0),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFE0A0),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            script['text']!,
            style: const TextStyle(
              fontSize: 18,
              height: 1.8,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 24),
          Text(
            '《${script['source']!.replaceAll('《', '').replaceAll('》', '')}》',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeButton() {
    return GestureDetector(
      onTap: _changeText,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh, color: Colors.grey[600], size: 20),
            const SizedBox(width: 8),
            Text(
              'Change one',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordingStatus() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Recording... ${_formatDuration(_recordingDuration)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordedContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 播放按钮
          GestureDetector(
            onTap: _playRecording,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFB347), Color(0xFFFF9538)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // 时长
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Recording',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDuration(_recordingDuration),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // 删除按钮
          GestureDetector(
            onTap: _deleteRecording,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordButton() {
    return GestureDetector(
      onTap: _isRecording ? _stopRecording : _startRecording,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppTheme.primaryColor,
            width: 3,
          ),
          color: _isRecording ? AppTheme.primaryColor.withOpacity(0.1) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          _isRecording ? Icons.stop : Icons.mic,
          size: 44,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}
