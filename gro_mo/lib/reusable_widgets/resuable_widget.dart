import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(imageName, fit: BoxFit.fitWidth, width: 240, height: 240);
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(
      color: Colors.black.withOpacity(0.9),
      fontFamily: 'Roboto',
    ),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.9),
          fontFamily: 'Roboto',
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container reusableButton(BuildContext context, String title, Function onTap,
    double buttonWidth, double buttonHeight, Color color) {
  return Container(
    width: buttonWidth,
    height: buttonHeight,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white24;
            }
            return color;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Roboto'),
      ),
    ),
  );
}

AlertDialog confirmAction(
    String message,
    String confirmText,
    Function confirmFunc,
    String denyText,
    Function denyFunc) {
  return AlertDialog(
    content: Text(message,
        style:
        const TextStyle(color: Colors.black, fontFamily: 'Roboto')),
    actions: [
      ElevatedButton(
          onPressed: () {
            confirmFunc();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF101D24),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Text(confirmText,
              style: const TextStyle(
                  color: Colors.white, fontFamily: 'Roboto'))),
      ElevatedButton(
          onPressed: () {
            denyFunc();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF101D24),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Text(denyText,
              style: const TextStyle(
                  color: Colors.white, fontFamily: 'Roboto')))
    ],
  );
}
