import 'package:flutter/material.dart';
import 'package:muebleria_valadez/provider/login_provider.dart';
import 'package:muebleria_valadez/screens/screen.dart';
import 'package:muebleria_valadez/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:muebleria_valadez/util/util.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            imageLogo(size),
            MultiProvider(providers: [
              ChangeNotifierProvider(create: (_) => LoginProvider())
            ], child: const LoginForm()),
          ],
        ),
      ),
    );
  }

  SafeArea imageLogo(Size size) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        height: size.height * 0.5,
        child: const Image(image: AssetImage('assets/Logo.png')),
      ),
    );
  }

  Container purpleBox(Size size) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFFB6AC9D),
        Color(0xFF9C8C72),
      ])),
      width: double.infinity,
      height: size.height * 0.6,
      child: Stack(
        children: [
          //Positioned(top: 90, left: 30, child: burbuja()),
          Positioned(top: -40, left: -30, child: burbuja()),
          Positioned(top: -50, right: -20, child: burbuja()),
          Positioned(bottom: -50, left: 10, child: burbuja()),
          Positioned(top: 120, left: -20, child: burbuja()),
          Positioned(bottom: 120, right: -20, child: burbuja()),
        ],
      ),
    );
  }

  Container burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _correoElectronico = TextEditingController();
  final _contrasena = TextEditingController();

  bool _mostrar = true;

  void showPassword() {
    if (_mostrar == true) {
      setState(() {
        _mostrar = false;
      });
    } else {
      setState(() {
        _mostrar = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LoginProvider>(context);
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 400),
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Container(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _correoElectronico,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: AppTheme.baseInput(
                                hintText: 'ejemplo@gmail.com',
                                labelText: 'Correo Electronico',
                                icon: Icons.alternate_email_outlined),
                            validator: (value) {
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regExp = RegExp(pattern);
                              return regExp.hasMatch(value ?? '')
                                  ? null
                                  : 'El valor ingresado no es un correo';
                            },
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _contrasena,
                            obscureText: _mostrar,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: AppTheme.baseInput(
                              hintText: '********',
                              labelText: 'Contraseña',
                              icon: Icons.lock_outline,
                              iconButton: IconButton(
                                  onPressed: () => showPassword(),
                                  icon: Icon(
                                      _mostrar
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppTheme.third)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo no puede estar vacio';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 50),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            disabledColor: Colors.grey,
                            color: AppTheme.primary,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 15),
                              child: Text(
                                lp.isLoading ? 'Cargando...' : 'Ingresar',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                                FocusScope.of(context).unfocus();
                                lp.isLoading = true;
                                List res = await lp.login(
                                    usuario: _correoElectronico.text,
                                    password: _contrasena.text);
                                if (res.isNotEmpty) {
                                  // ignore: use_build_context_synchronously
                                  Dialogos.msgDialog(
                                      context: context,
                                      texto: 'Bienvenido',
                                      dgt: DialogType.success,
                                      onPress: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => MainScreen(
                                                      usuario: res,
                                                    )),
                                            (Route<dynamic> route) => false);
                                      }).show();
                                } else {
                                  lp.isLoading = false;
                                  // ignore: use_build_context_synchronously
                                  Dialogos.msgDialog(
                                          context: context,
                                          color: const Color.fromARGB(
                                              255, 206, 66, 56),
                                          texto:
                                              'Datos Incorrectos, intenta de nuevo',
                                          dgt: DialogType.error,
                                          onPress: () {
                                            //Navigator.pushNamed(context, '/');
                                          })
                                      .show();
                                }
                              }
                            },
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
