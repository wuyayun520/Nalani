import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_tab_page.dart';
import 'dubbing_tab_page.dart';
import 'me_tab_page.dart';
import 'nalani_vip_screen.dart';
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

  // 检查是否是月订阅会员
  Future<bool> _checkMonthlyVipStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isVip = prefs.getBool('nalaniIsVip') ?? false;
    
    if (!isVip) {
      return false;
    }
    
    // 检查VIP是否过期
    final expiryStr = prefs.getString('nalaniVipExpiry');
    if (expiryStr != null) {
      final expiry = DateTime.tryParse(expiryStr);
      if (expiry != null && expiry.isBefore(DateTime.now())) {
        // VIP已过期
        await prefs.setBool('nalaniIsVip', false);
        return false;
      }
    }
    
    // 检查是否是月订阅会员
    final vipType = prefs.getString('nalaniVipType') ?? '';
    if (vipType != 'monthly') {
      return false;
    }
    
    return true;
  }

  // 检查并处理VIP访问配音功能
  Future<void> _checkAndShowDubbingModal() async {
    final isMonthlyVip = await _checkMonthlyVipStatus();
    
    if (isMonthlyVip) {
      // 月订阅会员，直接显示配音功能
      _showDubbingModal();
    } else {
      // 非月订阅会员，显示确认对话框
      if (mounted) {
        final shouldSubscribe = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Monthly VIP Required'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This feature requires Nalani Premium Monthly subscription.\nWould you like to subscribe?',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3D0),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFFF9538),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Subscription Plans:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            '• Weekly: ',
                            style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                          ),
                          const Text(
                            '\$12.99/week',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF9538),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text(
                            '• Monthly: ',
                            style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                          ),
                          const Text(
                            '\$49.99/month',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF9538),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF9538),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'POPULAR',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9538).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 16,
                              color: Color(0xFFFF9538),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Note: This feature requires Monthly subscription only.',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF666666),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Subscribe'),
              ),
            ],
          ),
        );

        if (shouldSubscribe == true && mounted) {
          // 跳转到VIP订阅页面，默认选择月订阅
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const VipScreen(initialIndex: 1),
            ),
          );
        }
      }
    }
  }

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
                                  _checkAndShowDubbingModal();
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

