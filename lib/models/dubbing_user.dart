class DubbingUser {
  final String userId;
  final String username;
  final String displayName;
  final String bio;
  final String voiceType;
  final String dubbingType;
  final int experienceYears;
  final String sex;
  final List<String> voiceStyle;
  final List<String> specializations;
  final String avatarPath;
  final String avatarBGPath;
  final String coverPath;
  final String videoPath;
  final String workPath;
  final String postTitle;
  final String postContent;
  final String workoutType;
  final List<String> tags;
  final int likes;

  DubbingUser({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.bio,
    required this.voiceType,
    required this.dubbingType,
    required this.experienceYears,
    required this.sex,
    required this.voiceStyle,
    required this.specializations,
    required this.avatarPath,
    required this.avatarBGPath,
    required this.coverPath,
    required this.videoPath,
    required this.workPath,
    required this.postTitle,
    required this.postContent,
    required this.workoutType,
    required this.tags,
    required this.likes,
  });

  factory DubbingUser.fromJson(Map<String, dynamic> json) {
    return DubbingUser(
      userId: json['userId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String,
      bio: json['bio'] as String,
      voiceType: json['voiceType'] as String,
      dubbingType: json['dubbingType'] as String,
      experienceYears: json['experienceYears'] as int,
      sex: json['sex'] as String,
      voiceStyle: List<String>.from(json['voiceStyle'] as List),
      specializations: List<String>.from(json['specializations'] as List),
      avatarPath: json['avatar']['path'] as String,
      avatarBGPath: json['avatarBG']['path'] as String,
      coverPath: json['cover']['path'] as String,
      videoPath: json['video']['path'] as String,
      workPath: json['work']['path'] as String,
      postTitle: json['postTitle'] as String,
      postContent: json['postContent'] as String,
      workoutType: json['workoutType'] as String,
      tags: List<String>.from(json['tags'] as List),
      likes: json['likes'] as int,
    );
  }
}

