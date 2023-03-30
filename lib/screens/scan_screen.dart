import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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

  Future<void> _sendImage(String base64Image) async {
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
    final message = result.data!['uploadImages']['response'];

    print('Image sent successfully: $success, message: $message');
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
            Container(
              width: size.width,
              height: size.height,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Container(
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
                      final base64Image = await _getImageFromCamera();
                      await _sendImage(base64Image!);
                    },
                    child: false
                        ? const SizedBox(
                            height: 17.0,
                            width: 17.0,
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          )
                        : const Text(
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
