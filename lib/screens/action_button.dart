import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const ActionButton({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
        child: Text(title),
        onPressed: () => onTap(),
      ),
    );
  }
}
