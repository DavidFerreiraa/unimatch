import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unimatch/helpers/toasts.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/uni_button.dart';
import 'package:unimatch/widgets/uni_text_field.dart';

//Turning SignIn State Less Widget into a State Full Widget
class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool startAnimation = false; //changes when the TextFields and button are visible
  bool isLoading = false;

  final TextEditingController nameTextFieldController = TextEditingController(); //controller to user text field
  final TextEditingController emailTextFieldController = TextEditingController(); //controller to email text field
  final TextEditingController passTextFieldController = TextEditingController(); //controller to password text field
  final TextEditingController confirmPassTextFieldController = TextEditingController(); //controller to confirm password text field
  final Toasts toasts = Toasts(); //instance of Toasts Widgets class
  FToast fToast = FToast(); //instance of fToast - flutter toast

  bool handleStartAnimation() { //change the "startAnimation" property and returns it
    setState(() {
      startAnimation = true;
    });
    return startAnimation;
  }

  bool handleIsLoading() { //set the "isLoading" to true or false
    setState(() {
      isLoading = !isLoading;
    });
    return isLoading;
  }

  void register() {
    //start loading
    handleIsLoading();

    if (passTextFieldController.text != confirmPassTextFieldController.text) {
      fToast.showToast(
        child: toasts.errorToast("Ambas as senhas devem ser iguais."),
        toastDuration: const Duration(seconds: 3),
        gravity: ToastGravity.TOP
      );
      handleIsLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return Scaffold(
      backgroundColor: MyColors.unimatchBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      "./assets/Images/unimatch-logo.svg",
                      width: 386,
                      height: 20,
                      ),
                  ),
                ),
              ),
              Focus(
                autofocus: true, //auto focus when its visible
                onFocusChange: (value) => handleStartAnimation(), //start the animation when the Widget is focused
                child: AnimatedOpacity(
                  curve: Curves.linear,
                  opacity: startAnimation? 1: 0,
                  duration: const Duration(seconds: 1),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: UniTextField(hintText: "Nome", controller: nameTextFieldController) //insert the controller into user text field
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: UniTextField(hintText: "E-mail", controller: emailTextFieldController, hideText: true)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: UniTextField(hintText: "Senha", controller: passTextFieldController, hideText: true)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: UniTextField(hintText: "Confirmar senha", controller: confirmPassTextFieldController, hideText: true)
                      ),
                      UniButton(btnText: "REGISTRAR", isLoading: isLoading, onPress: () => register()), //insert the controller in the password text field
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: RichText(text: TextSpan(text: "Já possui uma conta? ", style: const TextStyle(
                          color: MyColors.unimatchWhite
                        ), children: [
                          TextSpan(text: "Fazer login", style: const TextStyle(
                            color: MyColors.unimatchRed
                          ),
                          recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).pop()),
                        ])),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
