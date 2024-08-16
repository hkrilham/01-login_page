import 'package:flutter/material.dart';
import 'package:login_page/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Conroller email password
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // creat formKey
  final formKey = GlobalKey<FormState>();

  //password Visibiliti functions
  bool _visibility = false;
  void visibility() {
    setState(() {
      _visibility = !_visibility;
    });
  }

  // Email validate Functions
  bool validateEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login Page'),
      // ),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter the email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.amber,
                      ),
                      labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the email Address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _password,
                  obscureText: _visibility,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter the password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.amber,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _visibility ? Icons.visibility_off : Icons.visibility,
                          color: Colors.amber,
                        ),
                        onPressed: visibility,
                      ),
                      labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the password';
                    } else if (value.length < 6) {
                      return 'Enter the minumum 6 letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logon Success...')));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                loginUserEmail: _email.text,
                              ),
                            ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logon failed...')));
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
