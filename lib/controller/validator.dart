import 'package:flutter/material.dart';

class Validator {
  final formKey = GlobalKey<FormState>();

  String? funcao(String value) {
    if (value.trim().length <= 2)
      return "O nome deve conter pelo menos duas letras";

    return null;
  }

  bool isValidDate(String pDay, String pMonth, String pYear) {
    int year = int.parse(DateTime.now().year.toString());
    print(pDay);
    print(pMonth);
    print(pYear);
    print(year);
    try {

      if ((int.parse(pDay) > 0) && (int.parse(pDay) < 32)) {
        print('dia válido');
        if ((int.parse(pMonth) <= 12) && (int.parse(pMonth) > 0)) {
          print('mês válido');
          if ((int.parse(pYear)>1910) && (int.parse(pYear) < (year-17))) {
            print('ano válido');
            return true;
          }else {
            print('ano invalido');
            return false;
          }
        } else {
          print('mês inválido');
          return false;
        }
      } else {
        print('dia inválido');
        return false;
      }
    } catch (e) {
      print('não formatou');
      return false;
    }
  }

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;

  String? validateDataNascimento(String? value) =>
      value?.isEmpty ?? true ? "A data de vencimento não pode ser vazio" : null;

  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;

  String? validateEmail(String? value) =>
      value?.isEmpty ?? true ? "O email não pode ser vazio" : null;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty)
      return "A senha deve conter ao menos 6 caracteres";
    return null;
  }

  String? validateDate(String? value) {
    print(value);
    print(isValidDate);
    if ((value == null) || (value.isEmpty) || (value.length <10)) {
      return "A data deve ser preenchida DD/MM/AAAA";
    }
    String day = value.substring(0,2);
    String month = value.substring(3,5);
    String year = value.substring(6,10);
    print(isValidDate(day, month , year));
    if (isValidDate(day, month , year)) {
      print('validou');
       return null;
    } else
      return "Data informa é inválida!";
  }
}
