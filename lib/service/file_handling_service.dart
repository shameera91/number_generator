import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:my_virtual_number/constants.dart';

class FileHandlingService {
  void writeToFile(int userScore) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/test_file.txt');
    await file.writeAsString('$userScore');
  }

  void readFile() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/test_file.txt');
      String text = await file.readAsString();
      print('text file availbe text  ---------' + text);
      Constants.userPoints = int.parse(text);
    } catch (e) {
      print('Couldn\'t read file');
    }
  }
}
