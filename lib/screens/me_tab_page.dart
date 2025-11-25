import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_theme.dart';
import '../services/user_profile_service.dart';
import 'privacy_policy_page.dart';
import 'terms_of_service_page.dart';
import 'about_page.dart';

class MeTabPage extends StatefulWidget {
  const MeTabPage({super.key});

  @override
  State<MeTabPage> createState() => _MeTabPageState();
}

class _MeTabPageState extends State<MeTabPage> {
  final UserProfileService _profileService = UserProfileService();
  final ImagePicker _imagePicker = ImagePicker();
  
  String _userName = 'Julie';
  int _userAge = 26;
  String? _avatarPath;
  List<String> _voiceTags = ['Protagonist', 'Deep&powerful'];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final name = await _profileService.getUserName();
    final age = await _profileService.getUserAge();
    final avatarPath = await _profileService.getAvatarPath();
    final voiceTags = await _profileService.getVoiceTags();
    
    setState(() {
      _userName = name;
      _userAge = age;
      _avatarPath = avatarPath;
      _voiceTags = voiceTags;
      _isLoading = false;
    });
  }

  void _editVoiceTags() {
    List<String> selectedTags = List.from(_voiceTags);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Voice Tags',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _profileService.saveVoiceTags(selectedTags);
                      setState(() {
                        _voiceTags = selectedTags;
                      });
                      if (context.mounted) Navigator.pop(context);
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Select up to 3 tags',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: UserProfileService.availableVoiceTags.map((tag) {
                      final isSelected = selectedTags.contains(tag);
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            if (isSelected) {
                              selectedTags.remove(tag);
                            } else if (selectedTags.length < 3) {
                              selectedTags.add(tag);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Maximum 3 tags allowed'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryColor : const Color(0xFFFFF3D0),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? AppTheme.primaryColor : const Color(0xFFFFE0A0),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected ? Colors.white : const Color(0xFF666666),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAvatar() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image == null) return;

      final savedPath = await _profileService.saveAvatar(File(image.path));
      
      setState(() {
        _avatarPath = savedPath;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Avatar updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update avatar: $e')),
        );
      }
    }
  }

  void _editUserName() {
    final controller = TextEditingController(text: _userName);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter your name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                await _profileService.saveUserName(newName);
                setState(() {
                  _userName = newName;
                });
              }
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editUserAge() {
    final controller = TextEditingController(text: _userAge.toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Age'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter your age',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final newAge = int.tryParse(controller.text.trim());
              if (newAge != null && newAge > 0 && newAge < 150) {
                await _profileService.saveUserAge(newAge);
                setState(() {
                  _userAge = newAge;
                });
              }
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          // 顶部用户信息区域
          _buildUserSection(),
          const SizedBox(height: 20),
          // 用户名和年龄
          _buildUserName(),
          const SizedBox(height: 24),
          // Voice Tag
          _buildVoiceTagSection(),
          const SizedBox(height: 32),
          // Common Functions
          _buildFunctionsSection(context),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildUserSection() {
    return GestureDetector(
      onTap: _pickAvatar,
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.primaryColor,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: _avatarPath != null
                  ? Image.file(
                      File(_avatarPath!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultAvatar();
                      },
                    )
                  : Image.asset(
                      'assets/BaseRestriction/na_001/cover.webp',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultAvatar();
                      },
                    ),
            ),
          ),
          // 编辑图标
          Positioned(
            right: 12,
            bottom: 12,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: Colors.grey[300],
      child: const Icon(Icons.person, size: 80, color: Colors.grey),
    );
  }

  Widget _buildUserName() {
    return Row(
      children: [
        GestureDetector(
          onTap: _editUserName,
          child: Text(
            '$_userName,',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Color(0xFF333333),
            ),
          ),
        ),
        GestureDetector(
          onTap: _editUserAge,
          child: Text(
            '$_userAge ',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Color(0xFF333333),
            ),
          ),
        ),
        Image.asset(
          'assets/nalani_dubbing.webp',
          width: 28,
          height: 28,
          errorBuilder: (context, error, stackTrace) {
            return const Text('🌟', style: TextStyle(fontSize: 24));
          },
        ),
        const SizedBox(width: 8),
        // 编辑提示图标
        GestureDetector(
          onTap: _editUserName,
          child: Icon(
            Icons.edit,
            size: 18,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildVoiceTagSection() {
    return GestureDetector(
      onTap: _editVoiceTags,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Voice Tag:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.edit,
                size: 18,
                color: Colors.grey[400],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: _voiceTags.isEmpty
                ? [_buildTag('Tap to add tags')]
                : _voiceTags.map((tag) => _buildTag(tag)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3D0),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFE0A0),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF666666),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFunctionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Common Functions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        // 第一行功能按钮
        Row(
          children: [
            Expanded(child: _buildFunctionCard('Privacy\nPolicy', Icons.description, context)),
            const SizedBox(width: 12),
            Expanded(child: _buildFunctionCard('User\nAgreement', Icons.folder, context)),
          ],
        ),
        const SizedBox(height: 12),
        // 第二行功能按钮
        Row(
          children: [
            _buildFunctionCard('About us', Icons.waving_hand, context, width: 110),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _buildFunctionCard(String label, IconData icon, BuildContext context, {double? width}) {
    return GestureDetector(
      onTap: () {
        _handleFunctionTap(label, context);
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.primaryColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.primaryColor, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleFunctionTap(String label, BuildContext context) {
    String title = label.replaceAll('\n', ' ');
    
    switch (title) {
      case 'Privacy Policy':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PrivacyPolicyPage(),
          ),
        );
        break;
      case 'User Agreement':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TermsOfServicePage(),
          ),
        );
        break;
      case 'About us':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutPage(),
          ),
        );
        break;
    }
  }
}
