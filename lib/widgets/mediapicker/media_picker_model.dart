import 'dart:typed_data';

enum MediaType { image, video, both }
enum MediaSource { camera, gallery, both }

class MediaPickerConfig {
  final MediaType mediaType;
  final MediaSource source;
  final bool allowMultiple;
  final int maxItems;
  final bool enableCompression;
  final int imageQuality;

  const MediaPickerConfig({
    this.mediaType = MediaType.image,
    this.source = MediaSource.both,
    this.allowMultiple = true,
    this.maxItems = 0,
    this.enableCompression = true,
    this.imageQuality = 75,
  });
}

class MediaPickerResult {
  final Uint8List bytes;
  final String fileName;
  final String extension;
  final bool isVideo;
  String description;

  MediaPickerResult({
    required this.bytes,
    required this.fileName,
    required this.extension,
    required this.isVideo,
    this.description = "",
  });

  MediaPickerResult copyWith({Uint8List? bytes, String? description}) {
    return MediaPickerResult(
      bytes: bytes ?? this.bytes,
      fileName: fileName,
      extension: extension,
      isVideo: isVideo,
      description: description ?? this.description,
    );
  }
}