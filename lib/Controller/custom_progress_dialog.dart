import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class ProgressDialogHelper {
  static ProgressDialog? progressDialog;

  static void show(BuildContext context) {
    progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      isDismissible: false,
      showLogs: false,
      customBody: Container(
        width: 200.0, // Set the width of the dialog content
        height: 100.0, // Set the height of the dialog content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16.0),
            Text('Loading...'),
          ],
        ),
      ),
    );

    progressDialog?.style(
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );

    progressDialog?.show();
  }

  static void hide() {
    if (progressDialog != null && progressDialog!.isShowing()) {
      progressDialog?.hide();
    }
  }
}
