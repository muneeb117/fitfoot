import 'dart:io';
import 'package:fitfoot/core/global/widgets/toast_info.dart';
import 'package:fitfoot/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:http_parser/http_parser.dart';
import 'package:country_flags/country_flags.dart';

class CheckSizePage extends StatefulWidget {
  const CheckSizePage({super.key});

  @override
  State<CheckSizePage> createState() => _CheckSizePageState();
}

class _CheckSizePageState extends State<CheckSizePage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "Get Your Foot Size",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16.sp),
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final XFile image = await _controller!.takePicture();

            final String imagePath = image.path;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPictureScreen(imagePath: imagePath),
              ),
            );
          } catch (e) {
            showToast(msg: e.toString());
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "Display the Picture",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16.sp),
          ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.replay),
            ),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        DisplaySizeScreen(imagePath: imagePath),
                  ),
                );
              },
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplaySizeScreen extends StatefulWidget {
  final String imagePath;

  DisplaySizeScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  _DisplaySizeScreenState createState() => _DisplaySizeScreenState();
}

class _DisplaySizeScreenState extends State<DisplaySizeScreen> {
  late double size_cm;
  bool loading = true;
  String res = '';

  @override
  void initState() {
    super.initState();
    sendRequest();
  }

  Future<void> sendRequest() async {
    try {
      MultipartRequest request = MultipartRequest(
          'POST', Uri.parse('http://192.168.100.97:6000/image'));
      request.files.add(await MultipartFile.fromPath('img', widget.imagePath,
          contentType: MediaType('application', 'jpeg')));
      StreamedResponse r = await request.send();
      String responseString = await r.stream.bytesToString();
      RegExp regex = RegExp(r"[-+]?\d*\.?\d+");
      String? matchedNumber = regex.stringMatch(responseString);

      if (matchedNumber != null) {
        setState(() {
          size_cm = double.parse(matchedNumber);
          loading = false;
          print("New size received: $size_cm cm");
        });
      } else {
        setState(() {
          res = "No valid number found in response.";
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        res = "Failed to calculate size: $e";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "Calculated Foot Size",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16.sp),
          ),
        ),
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : buildSizeDisplay(context, size_cm),
      ),
    );
  }

  Widget buildSizeDisplay(BuildContext context, double size_cm) {
    double usSize = getUS(size_cm);
    double euroSize = getEURO(size_cm);
    double ukSize = getUK(size_cm);
    double pkSize = getPakistan(size_cm);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Foot Size: ${size_cm.toStringAsFixed(2)} cm',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          DataTable(
            columns: const [
              DataColumn(
                  label: Text('Country',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Size',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Row(
                  children: [
                    CountryFlag.fromCountryCode('US',
                        height: 15, width: 25), // US flag
                    const SizedBox(width: 10),
                    const Text('US'),
                  ],
                )),
                DataCell(Text(usSize.toString(),
                    style: const TextStyle(fontSize: 14))),
              ]),
              DataRow(cells: [
                DataCell(Row(
                  children: [
                    CountryFlag.fromCountryCode('AS',
                        height: 15, width: 25), // EU flag
                    const SizedBox(width: 10),
                    const Text('AS'),
                  ],
                )),
                DataCell(Text(euroSize.toString(),
                    style: const TextStyle(fontSize: 14))),
              ]),
              DataRow(cells: [
                DataCell(Row(
                  children: [
                    CountryFlag.fromCountryCode('GB',
                        height: 15, width: 25), // UK flag
                    const SizedBox(width: 10),
                    const Text('UK'),
                  ],
                )),
                DataCell(Text(ukSize.toString(),
                    style: const TextStyle(fontSize: 14))),
              ]),
              DataRow(cells: [
                DataCell(Row(
                  children: [
                    CountryFlag.fromCountryCode('PK',
                        height: 15, width: 25), // Pakistan flag
                    const SizedBox(width: 10),
                    const Text('Pakistan'),
                  ],
                )),
                DataCell(Text(pkSize.toString(),
                    style: const TextStyle(fontSize: 14))),
              ]),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.8),
              // primary: Colors.greenAccent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

// Include the size conversion functions here...

  double getUS(double cm) {
    if (cm <= 23.5)
      return 6;
    else if (cm <= 24.1)
      return 6.5;
    else if (cm <= 24.4)
      return 7;
    else if (cm <= 24.8)
      return 7.5;
    else if (cm <= 25.4)
      return 8;
    else if (cm <= 25.7)
      return 8.5;
    else if (cm <= 26)
      return 9;
    else if (cm <= 26.7)
      return 9.5;
    else if (cm <= 27)
      return 10;
    else if (cm <= 27.3)
      return 10.5;
    else if (cm <= 27.9)
      return 11;
    else if (cm <= 28.3)
      return 11.5;
    else if (cm <= 28.6)
      return 12;
    else if (cm <= 29.4)
      return 13;
    else if (cm <= 30.2)
      return 14;
    else if (cm <= 31) return 15;
    return -1; // Default case if no match found
  }

  double getEURO(double cm) {
    if (cm <= 23.5)
      return 39;
    else if (cm <= 24.1)
      return 39.5;
    else if (cm <= 24.4)
      return 40;
    else if (cm <= 24.8)
      return 40.5;
    else if (cm <= 25.4)
      return 41;
    else if (cm <= 25.7)
      return 42;
    else if (cm <= 26)
      return 42.5;
    else if (cm <= 26.7)
      return 43;
    else if (cm <= 27)
      return 43.5;
    else if (cm <= 27.3)
      return 44;
    else if (cm <= 27.9)
      return 44.5;
    else if (cm <= 28.3)
      return 45;
    else if (cm <= 28.6)
      return 45.5;
    else if (cm <= 29.4)
      return 46;
    else if (cm <= 30.2)
      return 47;
    else if (cm <= 31) return 48;
    return -1; // Default case if no match found
  }

  double getUK(double cm) {
    if (cm <= 23.5)
      return 5.5;
    else if (cm <= 24.1)
      return 6;
    else if (cm <= 24.4)
      return 6.5;
    else if (cm <= 24.8)
      return 7;
    else if (cm <= 25.4)
      return 7.5;
    else if (cm <= 25.7)
      return 8;
    else if (cm <= 26)
      return 8.5;
    else if (cm <= 26.7)
      return 9;
    else if (cm <= 27)
      return 9.5;
    else if (cm <= 27.3)
      return 10;
    else if (cm <= 27.9)
      return 10.5;
    else if (cm <= 28.3)
      return 11;
    else if (cm <= 28.6)
      return 11.5;
    else if (cm <= 29.4)
      return 12;
    else if (cm <= 30.2)
      return 13;
    else if (cm <= 31) return 14;
    return -1; // Default case if no match found
  }

  double getPakistan(double cm) {
    // Assuming size conversion for Pakistan follows a pattern similar to UK sizes
    if (cm <= 23.5)
      return 5;
    else if (cm <= 24.1)
      return 5.5;
    else if (cm <= 24.4)
      return 6;
    else if (cm <= 24.8)
      return 6.5;
    else if (cm <= 25.4)
      return 7;
    else if (cm <= 25.7)
      return 7.5;
    else if (cm <= 26)
      return 8;
    else if (cm <= 26.7)
      return 8.5;
    else if (cm <= 27)
      return 9;
    else if (cm <= 27.3)
      return 9.5;
    else if (cm <= 27.9)
      return 10;
    else if (cm <= 28.3)
      return 10.5;
    else if (cm <= 28.6)
      return 11;
    else if (cm <= 29.4)
      return 11.5;
    else if (cm <= 30.2)
      return 12;
    else if (cm <= 31) return 12.5;
    return -1; // Default case if no match found
  }
}
