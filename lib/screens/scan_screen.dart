import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dwaste/screens/home_screen.dart';
import 'package:dwaste/screens/reward_received_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../main.dart';
import '../models/app_colors.dart';
import '../models/gql_client.dart';

class ScanScreen extends StatefulWidget {
  ScanScreen({super.key});

  final CameraDescription camera = cameras.first;

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController _cameraController;
  bool dailyMilestone = false;

  Future<void> _sendImage(String base64Image) async {
    // context.loaderOverlay.show();
    final client = await getClient();

    final MutationOptions options = MutationOptions(
      document: gql(r'''
        mutation UploadImages($image: String!) {
  uploadImages(image: $image) {
    success
    message
    response
  }
}
      '''),
      variables: {
        'image': base64Image,
      },
    );

    debugPrint(base64Image);
    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print(result.exception);
      return;
    }

    final success = result.data!['uploadImages']['success'];
    final message = result.data!['uploadImages']['message'];
    final response = result.data!['uploadImages']['response'];

    if (success) {
      if (!mounted) {
        return;
      }
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const RewardScreen(),
      ));
    } else {
      if (message ==
          'Daily Milestone completed. No more DENR Tokens will be awarded') {
        dailyMilestone = true;
      }
      _showDialog(dailyMilestone);
    }

    print(
        'Image sent successfully: $success, message: $message, response: $response');
  }

  Future<void> _showDialog(bool dailyMilestone) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext ctx) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceAround,
          contentPadding: const EdgeInsets.all(16.0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28.0))),
          backgroundColor: AppColors.white,
          title: Center(
            child: dailyMilestone
                ? const Text('Daily Milestone completed',
                    style: TextStyle(
                        color: AppColors.green, fontWeight: FontWeight.w600))
                : const Text('Item not Recyclable',
                    style: TextStyle(
                        color: AppColors.green, fontWeight: FontWeight.w600)),
          ),
          content: SingleChildScrollView(
            child: dailyMilestone
                ? ListBody(
                    children: const <Widget>[
                      Center(
                          child: Text('No more DENR Tokens will be awarded')),
                      SizedBox(height: 10.0),
                      Center(child: Text('Please come back again tomorrow!')),
                    ],
                  )
                : ListBody(
                    children: const <Widget>[
                      Center(
                        child: Text(
                            'The Scanned item is not applicable for reward'),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Text('Please try again or scan other item'),
                      ),
                    ],
                  ),
          ),
          actions: <Widget>[
            Center(
              child: dailyMilestone
                  ? TextButton(
                      child: const Text(
                        'Okay',
                        style: TextStyle(color: AppColors.green),
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.of(ctx).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                      },
                    )
                  : TextButton(
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: AppColors.green),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Future<String?> _getImageFromCamera() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }

    final imageFile = await _cameraController.takePicture();

    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);
    final base64de = base64Decode(base64Image);

    return base64Image;
  }

  @override
  void initState() {
    super.initState();

    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return Container();
    }
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                    width: 100, // the actual width is not important here
                    child: CameraPreview(_cameraController!)),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.green),
                    ),
                    onPressed: () async {
                      context.loaderOverlay.show();

                      final base64Image = await _getImageFromCamera();
                      await _sendImage(base64Image!);

                      context.loaderOverlay.hide();
                    },
                    child: const Text(
                      'Scan',
                      style: TextStyle(color: AppColors.white),
                    ),
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
