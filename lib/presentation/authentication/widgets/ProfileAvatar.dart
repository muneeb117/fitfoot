// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../Controllers/authentication_controller.dart';
// import '../../../utils/colors.dart';
//
// class ProfileAvatar extends StatefulWidget {
//   @override
//   _ProfileAvatarState createState() => _ProfileAvatarState();
// }
//
// class _ProfileAvatarState extends State<ProfileAvatar> {
//   final authenticationController = Get.find<AuthenticationController>();
//
//
//   @override
//   void initState() {
//     super.initState();
//     authenticationController.resetImage();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         onTap: _showUploadOptions,
//         child: Obx(() {
//           File? _image = authenticationController.profileImage;
//           return Stack(
//             alignment: Alignment.center,
//             children: [
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: _image != null
//                     ? FileImage(_image)
//                     : AssetImage('assets/user.png') as ImageProvider,
//               ),
//               Positioned(
//                 right: 0, // Position the icon to the right
//                 bottom: 0, // Position the icon at the bottom
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   decoration: const BoxDecoration(
//                       color: AppColors.primaryElementText,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.primaryBackground,
//                           blurRadius: 100,
//                           spreadRadius: 2,
//                         )
//                       ]
//                   ),
//                   child: SizedBox(
//                     height: 24, // Set the height of the icon
//                     width: 24, // Set the width of the icon
//                     child: Container(
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage("assets/edit.png")
//                           )
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
//
//
//   void _showUploadOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: 150,
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 10,),
//               ListTile(
//                 leading: Image.asset("assets/photos.png",fit: BoxFit.cover,height: 30,width: 30,),
//                 title: Text("Gallery",style: TextStyle(color: AppColors.primaryBackground)),
//                 onTap: () {
//                   Navigator.pop(context);
//                   authenticationController.chooseImageFromGallery();
//                 },
//               ),
//               ListTile(
//                 leading: Image.asset("assets/camera.png",fit: BoxFit.cover,height: 30,width: 30,),
//                 title: Text("Camera",style: TextStyle(color: AppColors.primaryBackground)),
//                 onTap: () {
//                   Navigator.pop(context);
//                   authenticationController.captureImage();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
