import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_widget.dart';

class AlertBox {
  final BuildContext context;
  AwesomeDialog _successAlert;
  AwesomeDialog _errorAlert;

  void success(){
    _successAlert.show();
  }
  void error(){
    _errorAlert.show();
  }

  AlertBox(this.context){
    _successAlert = AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        title: 'Succes',
        desc: 'Je afspraak succesvol verzonden. Tot gauw!',
        btnOkIcon: Icons.check_circle,
      onDissmissCallback: (){ Home.of(context).currentIndex = 0; }
        );
    _errorAlert = AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'Fout',
        desc:
        'Er ging iets mis met het versturen van je afspraak. Probeer het later nog eens.',
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red);
  }
}
