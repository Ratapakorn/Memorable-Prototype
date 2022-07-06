import 'package:hive/hive.dart';
//import 'package:senex/models/User.g.dart';

part 'User.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? about;
  @HiveField(2)
  final String? imagePath;
  @HiveField(3)
  final bool? isDarkMode;

  User({required this.name, required this.about, required this.imagePath, this.isDarkMode = true});
}