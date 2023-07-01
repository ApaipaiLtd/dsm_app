// 只允许输入小数
import 'package:dsm_app/utils/util.dart';
import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.01;
  int scale;
  num? maxValue;
  String? tip;
  bool autoMax;
  NumberTextInputFormatter(
      {this.scale = 2, this.maxValue, this.tip, this.autoMax: false});
  static num strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return num.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value != "" &&
        value != defaultDouble.toString() &&
        strToFloat(value, defaultDouble) == defaultDouble) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    //不能超过最大值
    try {
      if (maxValue != null && value.isNotEmpty) {
        if (num.parse(value) > maxValue!) {
          if (autoMax) {
            value = maxValue.toString();
            selectionIndex = value.length;
          } else {
            Util.showToast("不能高于${tip ?? maxValue}");
            return oldValue;
          }
        }
      }
    } catch (e) {}

    ///小数点后位数
    int index = value.indexOf(".");
    if (value.contains(".")) {
      int lengthAfterPointer = value.substring(index, value.length).length - 1;

      ///小数位大于精度
      if (lengthAfterPointer > scale) {
        Util.showToast("最多输入$scale位小数");
        return oldValue;
      }
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
