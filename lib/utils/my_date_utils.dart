import 'package:intl/intl.dart';

class MyDateUtil {
  static displayDiff(int countSec) {
    int hr = (countSec / 3600).toInt();
    int minute = ((countSec % 3600) / 60).toInt();
    int sec = countSec % 60;
    String str = "";
    if (hr > 0) {
      str += "$hr hr ";
    }
    if (minute > 0) {
      str += "$minute min ";
    }

    str += "$sec s";
    return str;
  }

  static display(DateTime dt) {
    return DateFormat.yMMMd().format(dt);
  }

  static displayDateTime(DateTime dt) {
    return DateFormat.yMMMd().add_Hm().format(dt);
  }

  static String toDatabase(DateTime dt) {
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dt); // Save this
  }
}
