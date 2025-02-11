import 'package:fluttertoast/fluttertoast.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';

showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: mainColor,
    textColor: whiteColor,
    fontSize: 16.0,
  );
}
