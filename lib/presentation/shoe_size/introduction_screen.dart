import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'checkSizePage.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "Foot Measurement Instruction",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize:16.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            instructionStep('Step 1', 'Place an A4 size paper on the floor.',
                Icons.description),
            SizedBox(height: 10.h),
            instructionStep(
                'Step 2',
                'Place your feet on the paper, with the bottom of your feet aligned with the bottom edge of the paper.',
                Icons.touch_app),
            SizedBox(height: 10.h),
            instructionStep(
                'Step 3',
                'Take a picture of the paper along with your feet. Repeat until satisfied.',
                Icons.camera_alt),
            SizedBox(height: 10.h),
            instructionStep(
                'Step 4',
                'Click on the proceed icon to get your calculated shoe size.',
                Icons.forward),
            SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              iconAlignment: IconAlignment.end,
              icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14.sp),
              label: Text('Proceed to Measurement', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckSizePage()),
              ),
              style: ElevatedButton.styleFrom(
                padding:const  EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 16.sp),
                elevation: 2,  // Shadow depth
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
        )
          ],
        ),
      ),
    );
  }

  Widget instructionStep(String title, String description, IconData icon) {
    return ListTile(
      leading: Icon(icon, size: 20.sp),
      title: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: Colors.black)),
      subtitle: Text(description, style: TextStyle(fontSize: 12.sp)),
    );
  }
}
