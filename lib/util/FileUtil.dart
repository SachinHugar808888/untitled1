import 'dart:io';

class FileUtil {
  static bool doesFileExist(String filePath) {
    try {
      File file = File(filePath);
      return file.existsSync();
    } catch (e) {
      // Handle exceptions, e.g., log the error
      print('Error checking file existence: $e');
      return false;
    }
  }
}

class YourClass {
  void yourMethod() {
    // Example usage
    String filePath = "/sys/class/thermal/thermal_message/balance_mode";
    bool fileExists = FileUtil.doesFileExist(filePath);

    if (fileExists) {
      // The file exists, you can perform additional actions
      print("File exists: $filePath");

      // Your existing code for reading the file goes here
    } else {
      // Handle the case where the file doesn't exist
      print("File does not exist: $filePath");
    }
  }
}

void main() {
  // Example: Instantiate YourClass and call yourMethod
  YourClass yourClass = YourClass();
  yourClass.yourMethod();
}
