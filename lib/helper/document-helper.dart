import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class DocumentHelper {
  static DocumentHelper instance = DocumentHelper._();
  DocumentHelper._();

  Future<String> saveImageToLocalDirectory({
    required XFile pickedFile,
    required String folderName,
  }) async {
    // 1. Get the application documents directory
    final directory = await getApplicationDocumentsDirectory();

    // 2. Create a custom folder if it doesn't exist
    final String folderPath = p.join(directory.path, folderName);
    final Directory newFolder = Directory(folderPath);
    if (!await newFolder.exists()) {
      await newFolder.create(recursive: true);
    }

    // 3. Define the file name and path
    final String fileName = p.basename(pickedFile.path);
    final String savedPath = p.join(newFolder.path, fileName);

    // 4. Copy the file from the temporary cache to our permanent folder
    final File localImage = await File(pickedFile.path).copy(savedPath);

    return localImage.path;
  }
}
