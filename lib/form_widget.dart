import 'package:flutter/material.dart';
import 'package:knipmobile/alert.dart';

import 'home_widget.dart';
import 'main.dart';

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _FormWidgetState extends State<FormWidget> {
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String title = 'Stap 4: laat je gegevens achter.';

  AlertBox alert;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    alert = AlertBox(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: ColorConfig.white,
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 5.0,
          backgroundColor: ColorConfig.primary,
          title: Row(
            children: <Widget>[
              new IconButton(
                  icon: const Icon(Icons.arrow_back_sharp),
                  onPressed: () {
                    setState(() {
                      bool _keyboardVisible =
                          MediaQuery.of(context).viewInsets.bottom != 0;
                      if (_keyboardVisible) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        currentFocus.unfocus();
                      }
                      Home.of(context).currentIndex = 2;
                    });
                  }),
              Text(title)
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormName('Naam'),
                // The first text field is focused on as soon as the app starts.
                TextFormField(
                  autofocus: true,
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Voer een geldige naam in!';
                    }
                    return null;
                  },
                ),
                // The second text field is focused on when a user taps the
                // FloatingActionButton.
                FormName('Email'),
                TextFormField(
                    controller: emailController,
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      return !emailValid
                          ? "Voer een geldig email adres in!"
                          : null;
                    }),
                FormName('Telefoonnummer'),
                TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Voer een telefoonnummer in!';
                    }
                    return null;
                  },
                ),
                FormName('Opmerking'),
                TextFormField(
                  controller: commentController,
                  validator: (value) {
                    if (value.length > 100) {
                      return "Je tekst is te lang!";
                    } else {
                      return null;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // When the button is pressed,
          // give focus to the text field using myFocusNode.
          onPressed: () async {
            FocusScopeNode currentFocus = FocusScope.of(context);
            currentFocus.unfocus();
            if (_formKey.currentState.validate()) {
              Home.of(context).reservation.name = nameController.text;
              Home.of(context).reservation.email = emailController.text;
              Home.of(context).reservation.phonenumber = phoneController.text;
              Home.of(context).reservation.opmerking = commentController.text;

              bool success = await Home.of(context).reservation.send();
              if(success){
                alert.success();
              } else {
                alert.error();
              }
            }
          },
          tooltip: 'Focus Second Text Field',
          backgroundColor: ColorConfig.primary,
          child: Icon(Icons.send),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class FormName extends StatelessWidget {
  final String form;

  FormName(this.form);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        height: 22,
        child: Text(
          form + ':',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
