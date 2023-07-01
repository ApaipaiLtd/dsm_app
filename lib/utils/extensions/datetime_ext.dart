class DateTimeUtil {
  static DateTime fromWeekOfYear(int year, int week, {bool start: true}) {
    DateTime yearStartDate = DateTime(year);
    // 第一周的开始日期
    DateTime startDate = yearStartDate.subtract(Duration(days: yearStartDate.weekday));
    if (start) {
      return startDate.add(Duration(days: week * 7));
    } else {
      return startDate.add(Duration(days: (week + 1) * 7, milliseconds: -1));
    }
  }

  static DateTime fromQuarter(int year, int quarter, {bool start: true}) {
    if (start) {
      return DateTime(year, (quarter * 3) - 2);
    } else {
      return DateTime(year, (quarter * 3) + 1).subtract(Duration(milliseconds: 1));
    }
  }
}

extension DateTimeExt on DateTime {
  String format(String format) {
    int year = this.year;
    int month = this.month;
    int day = this.day;
    int hour = this.hour;
    int minute = this.minute;
    int second = this.second;
    int weekday = this.weekday;
    List week = ["日", "一", "二", "三", "四", "五", "六", "日"];
    //替换年份
    format = format.replaceAll("Y", year.toString());
    format = format.replaceAll("y", year.toString().substring(2));
    format = format.replaceAll("Q", ((month - 1) ~/ 3 + 1).toString());
    format = format.replaceAll("q", ((month - 1) ~/ 3 + 1).toString());
    //替换月份
    format = format.replaceAll("m", month.toString().padLeft(2, "0"));
    //替换日
    format = format.replaceAll("d", day.toString().padLeft(2, "0"));
    //替换小时
    format = format.replaceAll("H", hour.toString().padLeft(2, "0"));
    //替换分钟
    format = format.replaceAll("i", minute.toString().padLeft(2, "0"));
    //替换小时
    format = format.replaceAll("s", second.toString().padLeft(2, "0"));
    //替换星期
    format = format.replaceAll("w", week[weekday]);
    return format;
  }

  bool isSameDay(DateTime otherTime) {
    return this.year == otherTime.year && this.month == otherTime.month && this.day == otherTime.day;
  }

  bool isSameWeek(DateTime otherTime) {
    return this.year == otherTime.year && this.month == otherTime.month && this.weekOfYear == otherTime.weekOfYear; //&& (this.day - otherTime.day).abs() < 7
  }

  bool isSameMonth(DateTime otherTime) {
    return this.year == otherTime.year && this.month == otherTime.month;
  }

  bool isSameQuarter(DateTime otherTime) {
    return this.year == otherTime.year && this.quarter == otherTime.quarter;
  }

  int get quarter {
    return (this.month - 1) ~/ 3 + 1;
  }

  int get dayOfYear {
    DateTime yearStartDate = DateTime(this.year);
    return (this.millisecondsSinceEpoch - yearStartDate.millisecondsSinceEpoch) ~/ Duration.millisecondsPerDay;
  }

  int get weekOfYearTest {
    DateTime yearStartDate = DateTime(this.year);
    // 第一周的开始日期
    DateTime startDate = yearStartDate.add(Duration(days: 7 - (yearStartDate.weekday == 7 ? 0 : yearStartDate.weekday)));

    // 如果日期在第一周开始日期前
    if (this.isBefore(startDate)) {
      yearStartDate = DateTime(this.year - 1);
      startDate = yearStartDate.add(Duration(days: 7 - (yearStartDate.weekday == 7 ? 0 : yearStartDate.weekday)));
    }

    // print("第一周开始日期${startDate}");

    DateTime weekStartDate = this.subtract(Duration(days: this.weekday == 7 ? 0 : this.weekday));

    // print("本周开始日期$weekStartDate");
    // print("----------");
    // print(weekStartDate.millisecondsSinceEpoch - startDate.millisecondsSinceEpoch);
    // // print();
    // print("*************");
    int week = (weekStartDate.millisecondsSinceEpoch + 1 - startDate.millisecondsSinceEpoch) ~/ (Duration.millisecondsPerDay * 7) + 1;
    return week;
  }

  int get weekOfYear {
    DateTime yearStartDate = DateTime(this.year);
    // 第一周的开始日期
    DateTime startDate = yearStartDate.add(Duration(days: 7 - (yearStartDate.weekday == 7 ? 0 : yearStartDate.weekday)));

    // 如果日期在第一周开始日期前
    if (this.isBefore(startDate)) {
      yearStartDate = DateTime(this.year - 1);
      startDate = yearStartDate.add(Duration(days: 7 - (yearStartDate.weekday == 7 ? 0 : yearStartDate.weekday)));
    }

    // print("第一周开始日期${startDate}");

    DateTime weekStartDate = this.subtract(Duration(days: this.weekday == 7 ? 0 : this.weekday));

    // print("本周开始日期$weekStartDate");
    // print("----------");
    // print(weekStartDate.millisecondsSinceEpoch - startDate.millisecondsSinceEpoch);
    // // print();
    // print("*************");
    int week = (weekStartDate.millisecondsSinceEpoch + 1 - startDate.millisecondsSinceEpoch) ~/ (Duration.millisecondsPerDay * 7) + 1;
    return week;
  }

  String get timeAgo {
    int elapsed = DateTime.now().millisecondsSinceEpoch - this.millisecondsSinceEpoch;

    final num seconds = elapsed ~/ 1000;
    final num minutes = seconds ~/ 60;
    final num hours = minutes ~/ 60;
    final num days = hours ~/ 24;
    final num months = days ~/ 30;
    final num years = days ~/ 365;
    String result;
    if (seconds < 10) {
      result = "刚刚";
    } else if (seconds < 60) {
      result = "1分钟内";
    } else if (minutes < 60) {
      result = "$minutes分钟前";
    } else if (hours < 24) {
      result = "$hours小时前";
    } else if (days < 30) {
      result = "$days天前";
    } else if (days < 365) {
      result = "$months月前";
    } else {
      result = "$years年前";
    }

    return result;
  }

  int get secondsSinceEpoch => this.millisecondsSinceEpoch ~/ 1000;
}
