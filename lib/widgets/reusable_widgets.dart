import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';


// import 'cache_helper.dart';

Widget reusableElevatedButton({
  double width = double.infinity,
  double height = 50,
  double radius = 10,
  FontWeight fontWeight = FontWeight.bold,
  Color backColor = Colors.blue,
  Color textColor = Colors.white,
  Color shadowColor = Colors.grey,
  double fontSize = 14,
  required String label,
  required void Function()? function,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      style: ButtonStyle(
        shadowColor: MaterialStateProperty.all(shadowColor),
        backgroundColor: MaterialStateProperty.all<Color>(backColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      onPressed: function,
      child: Center(
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: textColor,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
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
  EdgeInsetsGeometry? padding,
  Icon? prefix,
  int? maxLines,
  TextStyle? style,
  Color? prefixColor,
  IconButton? suffix,
  bool obscure = false,
}) =>
    Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: TextFormField(
        style: style,
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        onTap: onTap,
        validator: validator,
        onFieldSubmitted: onSubmit,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: padding,
          suffixIcon: suffix,
          prefixIcon: prefix,
          prefixIconColor: prefixColor,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2.0, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: prefixColor,
          ),
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

Widget showFlushBar({
  required BuildContext context,
  required String message,
})=> Flushbar(
  message: message,
  icon: Icon(
    Icons.info_outline,
    size: 28.0,
    color: Colors.blue[300],
  ),
  margin: const EdgeInsets.all(6.0),
  flushbarStyle: FlushbarStyle.FLOATING,
  flushbarPosition: FlushbarPosition.TOP,
  textDirection: Directionality.of(context),
  borderRadius: BorderRadius.circular(12),
  duration: const Duration(seconds: 3),
  leftBarIndicatorColor: Colors.blue[300],
)..show(context);






PreferredSizeWidget defaultappbar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
})=> AppBar(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  titleSpacing: 5,
  leading: IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: const Icon(
      Icons.keyboard_arrow_left,
      size: 30,
      // color: Colors.black,
    ),
  ),
  title: Text(
    title!,
    style: const TextStyle(
      //  color: Colors.black,
    ),
  ),
  actions: actions,
);