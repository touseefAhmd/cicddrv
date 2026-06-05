import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../utils/snackbar.dart';
import 'media_picker_model.dart';
import 'media_picker_provider.dart';

class MediaPickerWidget extends StatefulWidget {
  final MediaPickerConfig config;
  final Function(List<MediaPickerResult>) onDone;
  final List<MediaPickerResult>? initialItems;

  const MediaPickerWidget({
    super.key,
    required this.config,
    required this.onDone,
    this.initialItems,
  });

  @override
  State<MediaPickerWidget> createState() => _MediaPickerWidgetState();
}

class _MediaPickerWidgetState extends State<MediaPickerWidget> {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  int cameraIndex = 0;
  bool flashOn = false;
  bool cameraAvailable = true;
  bool cameraInitializing = true;

  @override
  void initState() {
    super.initState();
    _initCameraAndProvider();
  }

  Future<void> _initCameraAndProvider() async {
    try {
      final provider = context.read<MediaPickerProvider>();
      provider.checkCameraAvailable();

      cameras = await availableCameras();
      if (await provider.checkCameraAvailable()){
        controller = CameraController(cameras[cameraIndex], ResolutionPreset.high);
        await controller!.initialize();
      }
      else {
        cameraAvailable = provider.cameraAvailable;
      }
    } catch (e) {
      cameraAvailable = false;
      print("Camera init error: $e");
    }

    if (widget.initialItems != null && widget.initialItems!.isNotEmpty) {
      if (!mounted) return;
      final provider = context.watch<MediaPickerProvider>();
      provider.setItems(widget.initialItems!);
    }

    cameraInitializing = false;
    if (mounted) setState(() {});
  }

  // Switch front/back camera
  Future<void> _switchCamera() async {
    if (kIsWeb) return; // Not supported on web
    if (cameras.length < 2) return;

    cameraIndex = 1 - cameraIndex;
    controller = CameraController(cameras[cameraIndex], ResolutionPreset.high);
    try {
      await controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      print("Switch camera error: $e");
    }
  }

  // Toggle flash
  Future<void> _toggleFlash() async {
    if (kIsWeb || controller == null) return; // Flash not supported on web

    flashOn = !flashOn;
    try {
      await controller!.setFlashMode(flashOn ? FlashMode.torch : FlashMode.off);
      if (mounted) setState(() {});
    } catch (e) {
      print("Flash toggle error: $e");
    }
  }

  // Take photo from camera
  Future<void> _takePhoto() async {
    final provider = context.read<MediaPickerProvider>();

    if (widget.config.maxItems > 0 &&
        provider.items.length >= widget.config.maxItems) {
      _showLimitReached();
      return;
    }

    if (controller == null ||
        !controller!.value.isInitialized ||
        controller!.value.isTakingPicture) {
      return;
    }

    try {
      // ✅ Flash handling (WEB SAFE)
      if (!kIsWeb) {
        try {
          await controller!.setFlashMode(
            flashOn ? FlashMode.torch : FlashMode.off,
          );
        } on CameraException catch (_) {}
      }

      final XFile file = await controller!.takePicture();

      if (!kIsWeb && flashOn) {
        await controller!.setFlashMode(FlashMode.off);
      }

      final bytes = await file.readAsBytes();
      _addToProvider(bytes, file.name, false);
    } catch (e, st) {
      print("Take photo error: $e");
      print("Stack: $st");
     // appPrintStack(st);
      HSnackBar.errorSnackBar(message: "Failed to capture image");
    }
  }

  // Pick images/videos from gallery
  Future<void> _pickFromGallery() async {
    if (widget.config.source == MediaSource.camera) return;

    final picker = ImagePicker();
    final provider = context.read<MediaPickerProvider>();
    final remaining = widget.config.maxItems > 0 ? widget.config.maxItems - provider.items.length : null;

    if (widget.config.mediaType == MediaType.image || widget.config.mediaType == MediaType.both) {
      if (widget.config.allowMultiple) {
        final files = await picker.pickMultiImage();
        if (files.isEmpty) return;
        for (var i = 0; i < files.length; i++) {
          if (remaining != null && i >= remaining) break;
          final f = files[i];
          final bytes = await f.readAsBytes();
          _addToProvider(bytes, f.name, false);
        }
        return;
      }

      final XFile? file = await picker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        if (remaining != null && remaining <= 0) {
          _showLimitReached();
          return;
        }

        final bytes = await file.readAsBytes();
        _addToProvider(bytes, file.name, false);
      }
    }

    if (widget.config.mediaType == MediaType.video || widget.config.mediaType == MediaType.both) {
      final XFile? file = await picker.pickVideo(source: ImageSource.gallery);
      if (file != null) {
        if (remaining != null && remaining <= 0) {
          _showLimitReached();
          return;
        }
        final bytes = await file.readAsBytes();
        _addToProvider(bytes, file.name, true);
      }
    }
  }

  void _addToProvider(Uint8List bytes, String name, bool isVideo) {
    final provider = context.read<MediaPickerProvider>();
    provider.add(
      MediaPickerResult(
        bytes: bytes,
        fileName: name,
        extension: name.split('.').last,
        isVideo: isVideo,
      ),
    );
  }

  void _showLimitReached() {
    HSnackBar.warningSnackBar(message: "Maximum ${widget.config.maxItems} items allowed");
  }

  void _onDone() {
    final provider = context.read<MediaPickerProvider>(); // use read, not watch
    widget.onDone(provider.items);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MediaPickerProvider>();
    final size = MediaQuery.of(context).size;

    if (cameraInitializing) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!cameraAvailable) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Camera Not Found"),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.of(context).pop(); }),
        ),
        body: Center(child: Text("No camera available on this device")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // =========================
          // Camera Preview Fullscreen
          // =========================
          if (controller != null && controller!.value.isInitialized)
            SizedBox(
              width: size.width,
              height: size.height,
              child: kIsWeb
                  ? IgnorePointer( // Web gestures fix
                ignoring: true,
                child: CameraPreview(controller!),
              )
                  : FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: 100,
                  height: 100 / controller!.value.aspectRatio,
                  child: CameraPreview(controller!),
                ),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),

          // =========================
          // Top controls: Back / Flash / Switch Camera
          // =========================
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                ),

                Row(
                  children: [
                    // Flash toggle
                    if (!kIsWeb)
                      IconButton(
                        onPressed: _toggleFlash,
                        icon: Icon(
                          flashOn ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    // Switch camera
                    if (!kIsWeb && cameras.length > 1)
                      IconButton(
                        onPressed: _switchCamera,
                        icon: const Icon(Icons.switch_camera, color: Colors.white, size: 30),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // =========================
          // Horizontal selected media
          // =========================
          if (provider.items.isNotEmpty)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: provider.items.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (_, i) {
                  final item = provider.items[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            item.bytes,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => provider.remove(i),
                            child: const CircleAvatar(
                              radius: 9,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close, size: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          // =========================
          // Bottom controls: Gallery / Shutter / Done
          // =========================
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Gallery button
                if (widget.config.source == MediaSource.gallery || widget.config.source == MediaSource.both)
                  GestureDetector(
                    onTap: _pickFromGallery,
                    child: const Icon(Icons.photo_library, color: Colors.white, size: 35),
                  )
                else
                  const SizedBox(width: 35),

                // Capture button
                if (widget.config.source == MediaSource.camera || widget.config.source == MediaSource.both)
                  GestureDetector(
                    onTap: _takePhoto,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 70),

                // Done button
                TextButton(
                  onPressed: _onDone,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  child: const Text("DONE", style: TextStyle(color: Colors.black, fontSize: 16)),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
