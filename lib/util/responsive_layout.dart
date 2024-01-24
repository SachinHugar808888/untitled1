import 'package:flutter/widgets.dart';

class ResponsiveLayout {
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 500 &&
        MediaQuery.of(context).size.height > 500;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 500 ||
        MediaQuery.of(context).size.height <= 500;
  }
}
