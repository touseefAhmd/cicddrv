import 'package:flutter/foundation.dart';
import 'media_picker_model.dart';
import 'package:camera/camera.dart';

class MediaPickerProvider extends ChangeNotifier {
  bool _cameraAvailable = false;
  bool get cameraAvailable => _cameraAvailable;

  Future<bool> checkCameraAvailable() async {
    try {
      final cameras = await availableCameras();
      bool available = cameras.isNotEmpty;

      _cameraAvailable = available;
      notifyListeners();

      return available;
    } catch (e) {
      print("Camera check error: $e");
      _cameraAvailable = false;
      notifyListeners();
      return false;
    }
  }

  final List<MediaPickerResult> _items = [];
  List<MediaPickerResult> get items => List.unmodifiable(_items);
  bool get hasItems => _items.isNotEmpty;

  void setItems(List<MediaPickerResult> items) {
    _items..clear()..addAll(items);
    notifyListeners();
  }

  void add(MediaPickerResult item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateItem(int index, MediaPickerResult newItem) {
    if (index >= 0 && index < _items.length) {
      _items[index] = newItem;
      notifyListeners();
    }
  }

  void updateDescription(int index, String description) {
    if (index >= 0 && index < _items.length) {
      _items[index] = _items[index].copyWith(description: description);
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  Map<String, dynamic> dynamicArgs = {};

  void setArguments(Map<String, dynamic> args) {
    dynamicArgs = args;
    notifyListeners();
  }

  void clearArguments() {
    dynamicArgs.clear();
    notifyListeners();
  }
}
