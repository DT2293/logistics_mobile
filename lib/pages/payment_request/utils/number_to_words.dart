    // Hàm chuyển số tiền thành chữ
    String convertNumberToWords(double number) {
      // Mảng ánh xạ số nguyên cơ bản
      const numberToWords = {0: 'Không',1: 'Một',2: 'Hai',3: 'Ba',4: 'Bốn',5: 'Năm',6: 'Sáu',7: 'Bảy',8: 'Tám',9: 'Chín',10: 'Mười',100: 'Trăm',1000: 'Nghìn',1000000: 'Triệu',1000000000: 'Tỷ',};
      // Hàm chuyển phần nguyên sang chữ
      String _convertPart(int number) {
        if (number == 0) return numberToWords[0]!;
        String result = '';
        if (number >= 100) {
          int hundreds = number ~/ 100;
          result += '${numberToWords[hundreds]} ${numberToWords[100]} ';
          number %= 100;
        }

        if (number >= 20) {
          int tens = number ~/ 10;
          result += '${numberToWords[tens]} Mươi ';
          number %= 10;
        } else if (number >= 10) {
          result += '${numberToWords[10]} ';
          number %= 10;
        }

        if (number > 0) {
          result += '${numberToWords[number]}';
        }

        return result.trim();
      }
      // Hàm chuyển phần nguyên thành chữ cho các nhóm (nghìn, triệu, tỷ,...)
      String convertIntegerPart(int number) {
        if (number == 0) return numberToWords[0]!;
        List<String> parts = [];
        List<int> unitValues = [1000000000,1000000,1000,1,]; // Tỷ, triệu, nghìn, đơn vị
        List<String> unitNames = ['Tỷ','Triệu','Nghìn','',]; // Đơn vị tương ứng
        for (int i = 0; i < unitValues.length; i++) {
          int unitValue = unitValues[i];
          if (number >= unitValue) {
            int part = number ~/ unitValue;
            parts.add('${_convertPart(part)} ${unitNames[i]}');
            number %= unitValue;
          }
        }
        return parts.join(' ').trim();
      }
      // Phần nguyên
      int integerPart = number.toInt();
      String integerPartInWords = convertIntegerPart(integerPart);
      // Phần thập phân
      String decimalPartInWords = '';
      if (number != integerPart) {
        String decimalPart = (number - integerPart).toString().substring(2);
        decimalPartInWords = 'phẩy ';
        for (int i = 0; i < decimalPart.length; i++) {
          decimalPartInWords += '${numberToWords[int.parse(decimalPart[i])]} ';
        }
      }

      return '$integerPartInWords $decimalPartInWords'.trim();
    }