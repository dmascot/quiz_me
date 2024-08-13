import 'package:flutter/material.dart';

/// class for Text buttons used tin quiz_me
/// it provides two types of button
/// - regular button which usually fits around text provided
/// - expanded buttons, which expands to all available space
///
/// properties:
/// - onPress , optional property which takes void function() as argument
/// - label: String parameter to show button "Name"
/// - color: Button colour
/// - isExpanded: parameter to check if we wanted expanded button or regular
///
/// private members:
/// - _button: class to build the button widget
class QuizButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String label;
  final ColorSwatch color;
  final bool isExpanded;

  const QuizButton(
      {required this.onPress,
      required this.label,
      required this.color,
      this.isExpanded = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Expanded(child: _button(onPress: onPress, label: label, color: color))
        : _button(onPress: onPress, label: label, color: color);
  }

  Widget _button(
      {required VoidCallback? onPress,
      required String label,
      required ColorSwatch color}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(40), color: color),
      child: TextButton(
          onPressed: onPress,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, color: Colors.white),
          )),
    );
  }
}
