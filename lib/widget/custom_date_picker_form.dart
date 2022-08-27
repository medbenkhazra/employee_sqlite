import 'package:flutter/material.dart';

class CustomDatepickerFormField extends StatelessWidget {
  final TextEditingController _controllerBirthday;

  final String _txtLbel;
  final VoidCallback _callBack;

  CustomDatepickerFormField(
      {Key? key,
      required TextEditingController controllerBirthday,
      required String txtLbel,
      required VoidCallback callBack})
      :_controllerBirthday=controllerBirthday,_txtLbel=txtLbel,_callBack=callBack,  super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(_txtLbel),
      ),
      controller: _controllerBirthday,
      
      keyboardType: TextInputType.name,
      
      onTap: _callBack,
    );
  }
}
