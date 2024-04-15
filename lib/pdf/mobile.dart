import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final directory = await getExternalStorageDirectory();
  final path = directory?.path; // Use null-aware operator
  if (path == null) {
    // Handle case where directory is null (e.g., permissions issue)
    print('Error: External storage directory is null.');
    return;
  }
  final file = File('$path/$fileName');
  try {
    await file.writeAsBytes(bytes, flush: true);
    await OpenFile.open('$path/$fileName');
  } catch (e) {
    print('Error saving or opening file: $e');
    // Handle the error appropriately, e.g., show an error message to the user.
  }
}
