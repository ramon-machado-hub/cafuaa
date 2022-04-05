import 'package:cafua/arguments/login_arguments.dart';
import 'package:cafua/modules/cadastro/authentication_service.dart';
import 'package:cafua/themes/app_colors.dart';
import 'package:cafua/themes/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/validator.dart';
import '../../widgets/button/button.dart';
import '../../widgets/input_text/input_text_widget.dart';

class LoginEmailPassword extends StatefulWidget {

  final LoginArguments arguments;
  const LoginEmailPassword({Key? key, required this.arguments}) : super(key: key);

  @override
  _LoginEmailPasswordState createState() => _LoginEmailPasswordState();
}

class _LoginEmailPasswordState extends State<LoginEmailPassword> {
  @override
  Widget build(BuildContext context) {
    final _controller = Validator();
    final _form = GlobalKey<FormState>();

    late String _email;
    late String _password;
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.05,
            colors: [
              AppColors.primaryGradient,
              AppColors.primary,
            ],
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(children: [

              //backbutton
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.09,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: AppColors.shape,
                              width: 1.5,
                            ),
                          )),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: AppColors.shape),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //label
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 30.0),
                child: Center(
                    child: Text(
                  "ENTRAR VIA "+widget.arguments.labelTypeLogin,
                  style: TextStyles.titlePoints,
                )),
              ),

              //email
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InputTextWidget(
                  backgroundColor: AppColors.shape,
                  borderColor: AppColors.input,
                  iconColor: AppColors.primary,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  label: widget.arguments.labelLogin,
                  icon: widget.arguments.iconLogin,
                  validator: _controller.validateEmail,
                  controller: TextEditingController(),
                  onChanged: (value) {
                    _email = value;
                  },
                ),
              ),

              //password
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InputTextWidget(
                  backgroundColor: AppColors.shape,
                  borderColor: AppColors.background,
                  iconColor: AppColors.primary,
                  obscureText: true,
                  keyboardType: TextInputType.name,
                  label: widget.arguments.labelPassword,
                  icon: Icons.password_outlined,
                  validator: _controller.validatePassword,
                  controller: TextEditingController(),
                  onChanged: (value) {
                    _password = value;
                  },
                ),
              ),

              ButtonTheme(
                minWidth: 200.0,
                height: 70.0,
                child: Button(
                    colorButton: AppColors.buttonGame,
                    label: 'ENTRAR',
                    onTap: () {
                      if (_form.currentState!.validate()) {
                        _form.currentState!.save();
                        AuthenticationService()
                            .signIn(email: _email, password: _password)
                            .then((result) {
                          if (result == null) {
                            Navigator.pushReplacementNamed(context, "/home");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                result,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ));
                          }
                        });
                        // Navigator.pushReplacementNamed(context, "/home");
                      }
                    }),
              ),
            ]),
            /*
                Container(
                color: AppColors.primary,
                child: Stack(children: [
                  //backButton
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.02,
                    left: MediaQuery.of(context).size.height * 0.02,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: AppColors.background,
                              width: 1.5,
                            ),
                          )),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: AppColors.shape),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ),
                  //label
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: MediaQuery.of(context).size.height * 0.05,
                    child:
                      SizedBox(
                        width: MediaQuery.of(context).size.height *0.6,
                        child: Center(child: Text("ENTRAR VIA CAFUA", style: TextStyles.titleHome,))),
                  ),


                  //email
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.7,
                    left: MediaQuery.of(context).size.height * 0.05,
                    child: InputTextWidget(
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      label: "Email",
                      icon: Icons.email,
                      validator: _controller.validateEmail,
                      controller: TextEditingController(),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),

                  //password
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.7,
                    left: MediaQuery.of(context).size.height * 0.05,
                    child: InputTextWidget(
                      obscureText: true,
                      keyboardType: TextInputType.name,
                      label: "Senha",
                      icon: Icons.password_outlined,
                      validator: _controller.validatePassword,
                      controller: TextEditingController(),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),

                ]),*/
          ),
        ),
      ),
    );
  }
}
