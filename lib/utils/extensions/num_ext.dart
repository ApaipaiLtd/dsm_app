extension NumExt on num {
  String format({int point: 3, bool divider: true}) {
    String str = this.toStringAsFixed(point);
    // 去除小数末尾的0
    for (int i = point; i > 0; i--) {
      if (str.endsWith('0')) {
        str = str.substring(0, str.length - 1);
      }
    }
    // 分开截取
    List<String> sub = str.split('.');
    // 处理值
    List val = List.from(sub[0].split(''));
    // 处理点
    List<String> points = [];
    if (sub.length == 2) {
      points = List.from(sub[1].split(''));
    }

    //处理分割符
    if (divider) {
      for (int index = 0, i = val.length - 1; i >= 0; index++, i--) {
        // 除以三没有余数、不等于零并且不等于1 就加个逗号
        if (index % 3 == 0 && index != 0) val[i] = val[i] + ',';
      }
    }

    // 判断是否有长度
    if (points.length > 0) {
      return '${val.join('')}.${points.join('')}';
    } else {
      return val.join('');
    }
  }
}
