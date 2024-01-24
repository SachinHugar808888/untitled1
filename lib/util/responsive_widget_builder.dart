// responsive_widget_builder.dart
import 'package:flutter/material.dart';
import 'responsive_layout.dart';

class ResponsiveWidgetBuilder {
  static bool isDesktop(BuildContext context) {
    return ResponsiveLayout.isDesktop(context);
  }

  static Widget buildResponsiveContainer(
      BuildContext context, {
        required List<Widget> children,
        double desktopWidthFactor = 0.5, // Set to 0.5 for half the screen width on desktop
        double mobileWidthFactor = 1,
        double desktopHeightFactor = 0.8,
        double mobileHeightFactor = 0.9,
        MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
        CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
        Axis direction = Axis.vertical,
        EdgeInsetsGeometry? padding,
      }) {
    double containerWidth = isDesktop(context)
        ? MediaQuery.of(context).size.width * desktopWidthFactor
        : MediaQuery.of(context).size.width * mobileWidthFactor;

    // Ensure that the width doesn't exceed MediaQuery.of(context).size.width
    containerWidth = containerWidth.clamp(0.0, MediaQuery.of(context).size.width);

    return Container(
      width: double.infinity, // Set to cover full width
      height: double.infinity, // Set to cover full height
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/app_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: containerWidth,
          height: isDesktop(context)
              ? MediaQuery.of(context).size.height * desktopHeightFactor
              : MediaQuery.of(context).size.height * mobileHeightFactor,
          padding: padding ?? EdgeInsets.all(16),
          child: SingleChildScrollView(

            child: Flex(
              direction: direction,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: isDesktop(context)
                  ? CrossAxisAlignment.center
                  : crossAxisAlignment,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}