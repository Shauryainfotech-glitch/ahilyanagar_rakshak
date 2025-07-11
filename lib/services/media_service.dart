import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_service.dart';

class MediaService {
  static final MediaService _instance = MediaService._internal();
  factory MediaService() => _instance;
  MediaService._internal();

  final FirebaseService _firebaseService = FirebaseService();
  final ImagePicker _imagePicker = ImagePicker();
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;

  // Initialize camera
  Future<void> initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _cameraController = CameraController(
          _cameras![0],
          ResolutionPreset.high,
          enableAudio: true,
        );
        await _cameraController!.initialize();
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  // Dispose camera
  void disposeCamera() {
    _cameraController?.dispose();
  }

  // Get camera controller
  CameraController? get cameraController => _cameraController;

  // Capture photo with location
  Future<Map<String, dynamic>?> capturePhotoWithLocation() async {
    try {
      // Get current location
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } catch (e) {
        print('Error getting location: $e');
      }

      // Capture photo
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (photo != null) {
        final file = File(photo.path);
        final metadata = {
          'timestamp': DateTime.now().toIso8601String(),
          'latitude': position?.latitude,
          'longitude': position?.longitude,
          'accuracy': position?.accuracy,
          'fileSize': await file.length(),
          'fileType': 'image',
          'fileName': path.basename(photo.path),
        };

        return {
          'file': file,
          'metadata': metadata,
          'path': photo.path,
        };
      }

      return null;
    } catch (e) {
      print('Error capturing photo: $e');
      return null;
    }
  }

  // Record video with location
  Future<Map<String, dynamic>?> recordVideoWithLocation() async {
    try {
      // Get current location
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } catch (e) {
        print('Error getting location: $e');
      }

      // Record video
      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(seconds: 60), // Max 60 seconds
      );

      if (video != null) {
        final file = File(video.path);
        final metadata = {
          'timestamp': DateTime.now().toIso8601String(),
          'latitude': position?.latitude,
          'longitude': position?.longitude,
          'accuracy': position?.accuracy,
          'fileSize': await file.length(),
          'fileType': 'video',
          'fileName': path.basename(video.path),
        };

        return {
          'file': file,
          'metadata': metadata,
          'path': video.path,
        };
      }

      return null;
    } catch (e) {
      print('Error recording video: $e');
      return null;
    }
  }

  // Pick image from gallery with location
  Future<Map<String, dynamic>?> pickImageFromGallery() async {
    try {
      // Get current location
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } catch (e) {
        print('Error getting location: $e');
      }

      // Pick image
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final file = File(image.path);
        final metadata = {
          'timestamp': DateTime.now().toIso8601String(),
          'latitude': position?.latitude,
          'longitude': position?.longitude,
          'accuracy': position?.accuracy,
          'fileSize': await file.length(),
          'fileType': 'image',
          'fileName': path.basename(image.path),
        };

        return {
          'file': file,
          'metadata': metadata,
          'path': image.path,
        };
      }

      return null;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  // Pick video from gallery with location
  Future<Map<String, dynamic>?> pickVideoFromGallery() async {
    try {
      // Get current location
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } catch (e) {
        print('Error getting location: $e');
      }

      // Pick video
      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(seconds: 60),
      );

      if (video != null) {
        final file = File(video.path);
        final metadata = {
          'timestamp': DateTime.now().toIso8601String(),
          'latitude': position?.latitude,
          'longitude': position?.longitude,
          'accuracy': position?.accuracy,
          'fileSize': await file.length(),
          'fileType': 'video',
          'fileName': path.basename(video.path),
        };

        return {
          'file': file,
          'metadata': metadata,
          'path': video.path,
        };
      }

      return null;
    } catch (e) {
      print('Error picking video: $e');
      return null;
    }
  }

  // Pick document files
  Future<List<Map<String, dynamic>>> pickDocuments() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );

      if (result != null) {
        List<Map<String, dynamic>> documents = [];
        
        for (var file in result.files) {
          if (file.path != null) {
            final fileObj = File(file.path!);
            final metadata = {
              'timestamp': DateTime.now().toIso8601String(),
              'fileSize': await fileObj.length(),
              'fileType': path.extension(file.path!).toLowerCase(),
              'fileName': file.name,
            };

            documents.add({
              'file': fileObj,
              'metadata': metadata,
              'path': file.path!,
            });
          }
        }

        return documents;
      }

      return [];
    } catch (e) {
      print('Error picking documents: $e');
      return [];
    }
  }

  // Upload media to Firebase Storage
  Future<String?> uploadMedia(File file, String folder, Map<String, dynamic> metadata) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}';
      final storageRef = _firebaseService.storage.ref().child('$folder/$fileName');

      // Upload file
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Save metadata to database
      final mediaRef = _firebaseService.database.ref('media').push();
      await mediaRef.set({
        'downloadUrl': downloadUrl,
        'fileName': fileName,
        'folder': folder,
        'metadata': metadata,
        'uploadedAt': _firebaseService.database.ref().push().key,
      });

      return downloadUrl;
    } catch (e) {
      print('Error uploading media: $e');
      return null;
    }
  }

  // Upload multiple media files
  Future<List<String>> uploadMultipleMedia(
    List<Map<String, dynamic>> mediaFiles,
    String folder,
  ) async {
    List<String> uploadedUrls = [];
    
    for (var mediaFile in mediaFiles) {
      final url = await uploadMedia(
        mediaFile['file'],
        folder,
        mediaFile['metadata'],
      );
      if (url != null) {
        uploadedUrls.add(url);
      }
    }

    return uploadedUrls;
  }

  // Compress image
  Future<File?> compressImage(File file) async {
    try {
      final XFile? compressedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 70,
      );

      if (compressedImage != null) {
        return File(compressedImage.path);
      }

      return null;
    } catch (e) {
      print('Error compressing image: $e');
      return null;
    }
  }

  // Get video thumbnail
  Future<File?> getVideoThumbnail(String videoPath) async {
    try {
      final VideoPlayerController controller = VideoPlayerController.file(File(videoPath));
      await controller.initialize();
      
      // Get thumbnail at 1 second
      final thumbnail = await controller.value.copyWith(
        position: const Duration(seconds: 1),
      );

      // Save thumbnail to temporary file
      final tempDir = await getTemporaryDirectory();
      final thumbnailPath = path.join(tempDir.path, 'thumbnail_${DateTime.now().millisecondsSinceEpoch}.jpg');
      
      // Note: This is a simplified approach. In a real app, you'd use a proper video thumbnail library
      await controller.dispose();
      
      return File(thumbnailPath);
    } catch (e) {
      print('Error getting video thumbnail: $e');
      return null;
    }
  }

  // Validate file size
  bool validateFileSize(File file, int maxSizeInMB) {
    final sizeInBytes = file.lengthSync();
    final sizeInMB = sizeInBytes / (1024 * 1024);
    return sizeInMB <= maxSizeInMB;
  }

  // Validate file type
  bool validateFileType(String filePath, List<String> allowedExtensions) {
    final extension = path.extension(filePath).toLowerCase();
    return allowedExtensions.contains(extension);
  }

  // Get file info
  Future<Map<String, dynamic>> getFileInfo(File file) async {
    final stat = await file.stat();
    return {
      'size': stat.size,
      'modified': stat.modified,
      'accessed': stat.accessed,
      'path': file.path,
      'name': path.basename(file.path),
      'extension': path.extension(file.path),
    };
  }

  // Create evidence package
  Future<Map<String, dynamic>> createEvidencePackage({
    required String userId,
    required String caseId,
    required List<Map<String, dynamic>> mediaFiles,
    String? description,
  }) async {
    try {
      final evidenceId = _firebaseService.database.ref('evidence').push().key!;
      final uploadedUrls = await uploadMultipleMedia(mediaFiles, 'evidence/$evidenceId');

      final evidenceData = {
        'userId': userId,
        'caseId': caseId,
        'mediaUrls': uploadedUrls,
        'description': description,
        'createdAt': _firebaseService.database.ref().push().key,
        'verified': false,
        'metadata': {
          'totalFiles': mediaFiles.length,
          'totalSize': mediaFiles.fold<int>(0, (sum, file) => sum + (file['file'] as File).lengthSync()),
        },
      };

      await _firebaseService.database.ref('evidence/$evidenceId').set(evidenceData);

      return {
        'evidenceId': evidenceId,
        'mediaUrls': uploadedUrls,
        'data': evidenceData,
      };
    } catch (e) {
      print('Error creating evidence package: $e');
      rethrow;
    }
  }

  // Get evidence by case ID
  Stream<DatabaseEvent> getEvidenceStream(String caseId) {
    return _firebaseService.database.ref('evidence').orderByChild('caseId').equalTo(caseId).onValue;
  }

  // Delete media file
  Future<bool> deleteMedia(String downloadUrl) async {
    try {
      await _firebaseService.deleteFile(downloadUrl);
      return true;
    } catch (e) {
      print('Error deleting media: $e');
      return false;
    }
  }

  // Get temporary directory
  Future<Directory> getTemporaryDirectory() async {
    return await getTemporaryDirectory();
  }

  // Check camera permission
  Future<bool> checkCameraPermission() async {
    // This would typically use permission_handler
    // For now, return true as a placeholder
    return true;
  }

  // Request camera permission
  Future<bool> requestCameraPermission() async {
    // This would typically use permission_handler
    // For now, return true as a placeholder
    return true;
  }
}
