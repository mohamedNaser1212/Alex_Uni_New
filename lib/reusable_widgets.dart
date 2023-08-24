import 'package:flutter/material.dart';


// import 'cache_helper.dart';

Widget reusableElevatedButton({
  double width = double.infinity,
  double height = 50,
  double radius = 10,
  Color backColor = Colors.blue,
  Color textColor = Colors.white,
  required String label,
  required void Function()? function,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      onPressed: function,
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: textColor,
        ),
      ),
    ),
  );
}

Widget reusableTextFormField({
  required String label,
  double borderRadius = 25,
  Color activeColor = Colors.blue,
  required void Function() onTap,
  String? Function(String?)? validator,
  String? Function(String?)? onSubmit,
  required TextEditingController controller,
  required TextInputType keyboardType,
  Icon? prefix,
  IconButton? suffix,
  bool obscure = false,
}) =>
    Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        onTap: onTap,
        validator: validator,
        onFieldSubmitted: onSubmit,
        decoration: InputDecoration(
          suffixIcon: suffix,
          prefixIcon: prefix,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2.0, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          labelText: label,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: activeColor, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );

void navigateTo({

  required context,
  required Widget screen,
}) {

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
void navigateReplacement({
  required context,
  required Widget screen,
}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
void navigateAndFinish({
  required context,
  required Widget screen,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (builder) => screen,
    ),
    (route) => false,
  );
}

// void signout({
//   required BuildContext context,
//   required Widget screen,
// }) {
//   CacheHelper.removeData(key: 'uId');
//   navigateAndFinish(
//     context: context,
//     screen: screen,
//   );
// }

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
