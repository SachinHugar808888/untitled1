import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static void showCustomDialog(BuildContext context, String content, VoidCallback onClose) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (onClose != null) {
                  onClose(); // Call the callback function when the dialog is closed
                }
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

