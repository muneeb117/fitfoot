import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../../../core/theme/app_colors.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String? _profileImageUrl;
  String? _userName;
  Database? _database;
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, "profile.db");

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE user_profile (user_id TEXT PRIMARY KEY, image_path TEXT, user_name TEXT)',
        );
      },
    );

    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    if (_isDataLoaded) return; // Prevent reloading data unnecessarily

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final profileData = await _database?.query(
        'user_profile',
        where: 'user_id = ?',
        whereArgs: [user.uid],
      );

      if (profileData != null && profileData.isNotEmpty) {
        setState(() {
          _profileImageUrl = profileData.first['image_path'] as String?;
          _userName = profileData.first['user_name'] as String?;
          _isDataLoaded = true;
        });
      } else {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          final imageUrl = doc.data()?['imageUrl'] ?? '';
          final name = doc.data()?['name'] ?? '';

          setState(() {
            _profileImageUrl = imageUrl.isNotEmpty ? imageUrl : null;
            _userName = name.isNotEmpty ? name : "Enter your name";
            _isDataLoaded = true;
          });

          await _database?.insert(
            'user_profile',
            {
              'user_id': user.uid,
              'image_path': imageUrl,
              'user_name': name.isNotEmpty ? name : "Enter your name",
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        } else {
          setState(() {
            _profileImageUrl = null;
            _userName = "Enter your name";
            _isDataLoaded = true; // No data found
          });
        }
      }
    }
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final fileName = path.basename(pickedFile.path);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images/${user.uid}/$fileName');

        await storageRef.putFile(File(pickedFile.path));
        final downloadUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .update({'imageUrl': downloadUrl});

        await _database?.update(
          'user_profile',
          {'image_path': downloadUrl},
          where: 'user_id = ?',
          whereArgs: [user.uid],
        );

        setState(() {
          _profileImageUrl = downloadUrl;
        });
      }
    }
  }

  Future<void> _editUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final newName = await showDialog<String>(
        context: context,
        builder: (context) {
          String? tempName = _userName == "Enter your name" ? "" : _userName;
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            title: Text(
              'Edit Name',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold,color: Colors.white),
            ),
            content: TextField(
              onChanged: (value) {
                tempName = value;
              },
              controller: TextEditingController(text: tempName),
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.labelSmall,
                hintText: "Enter your name",
                filled: true,
                fillColor: AppColors.card,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel',
                    style: Theme.of(context).textTheme.bodySmall!),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  textStyle: TextStyle(fontSize: 14.sp),
                ),
                child: Text(
                  'Save',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.primary),
                ),
                onPressed: () => Navigator.of(context).pop(tempName),
              ),
            ],
          );
        },
      );

      if (newName != null && newName.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'name': newName});

        await _database?.update(
          'user_profile',
          {'user_name': newName},
          where: 'user_id = ?',
          whereArgs: [user.uid],
        );

        setState(() {
          _userName = newName;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color:  AppColors.background,
      elevation:0 ,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: _isDataLoaded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: _profileImageUrl != null &&
                                _profileImageUrl!.isNotEmpty
                            ? CachedNetworkImageProvider(_profileImageUrl!)
                            : null,
                        child: _profileImageUrl == null
                            ? Image.asset(
                                'assets/images/user.png') // Default icon if no image
                            : null,
                      ),
                      Positioned(
                        bottom: -6,
                        right: -8,
                        child: IconButton(
                          icon: SvgPicture.asset('assets/icons/edit.svg'),
                          onPressed: _pickAndUploadImage,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: _editUserName,
                    child: Text(
                      _userName ?? "Enter your name",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              )
            : Center(
                child:
                    CircularProgressIndicator()), // Show loading indicator while data is being fetched
      ),
    );
  }
}
