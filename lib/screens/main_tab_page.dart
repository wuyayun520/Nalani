import 'package:flutter/material.dart';
import 'home_tab_page.dart';
import 'dubbing_tab_page.dart';
import 'me_tab_page.dart';
import '../widgets/app_background.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTabPage(),
    const SizedBox(), // Placeholder for Dubbing (will show as modal)
    const MeTabPage(),
  ];

  void _showDubbingModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DubbingTabPage(),
    );
  }

  String _getCurrentTabImage() {
    switch (_currentIndex) {
      case 0:
        return 'assets/nalani_home_nor.webp';
      case 1:
        return 'assets/nalani_dubbing_nor.webp';
      case 2:
        return 'assets/nalani_me_nor.webp';
      default:
        return 'assets/nalani_home_nor.webp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: Stack(
          children: [
            Positioned.fill(
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            ),
            Positioned(
              bottom: 54,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Image.asset(
                        _getCurrentTabImage(),
                        width: 250,
                        height: 94,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 250,
                            height: 94,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.error_outline),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: 250,
                        height: 94,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _currentIndex = 0;
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _showDubbingModal();
                                },
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _currentIndex = 2;
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

