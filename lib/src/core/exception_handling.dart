import 'package:ark_module_profile/ark_module_profile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ExceptionHandle {
  static execute(Failure fail) {
    if (fail is HttpFailure) {
      Fluttertoast.showToast(msg: "Error ${fail.code}x : ${fail.message}");
    } else {
      Fluttertoast.showToast(
          msg: "Failed connect to server \n Please check your connection");
    }
  }
}
