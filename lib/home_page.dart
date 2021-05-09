import 'package:fingerprintauth2/second_page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometric;
  List<BiometricType> _availableBiometric;
  String autherized = "Não Autorizado";

  Future<void> _checkBiometric() async {
    bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      // print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometric;
    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      // print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "", useErrorDialogs: true, stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      autherized = authenticated ? "Autorizado com Sucesso " : "Não Autorizado";
      if (authenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageAuth(),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Finger Print Auth'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/image/finger.png',
                      width: 160,
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        'Use sua Impressão Digital Para Logar',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, height: 2),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      // width: double.infinity,
                      child: SizedBox(
                        height: 50,
                        width: 260,
                        child: ElevatedButton(
                          child: Text('Autenticação'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black, // background
                            onPrimary: Colors.white,
                            shadowColor: Colors.black,
                            elevation: 10,
                            textStyle: TextStyle(fontSize: 20),
                            shape: (RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.grey),
                            )), // foreground
                          ),
                          onPressed: _authenticate,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Checar Impressão Digital: $_canCheckBiometric"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Tipo: $_availableBiometric"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Situação: $autherized"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
